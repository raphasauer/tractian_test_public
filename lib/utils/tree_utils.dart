import '../models/asset.dart';
import '../models/base.dart';
import '../models/location.dart';

Map<String, Base> buildTreeFromList(List<Base> nodes) {
  Map<String, Base> nodeMap = {for (var node in nodes) node.id: node};

  for (var node in nodes) {
    if (node.parentId != null) {
      var parentNode = nodeMap[node.parentId];
      if (parentNode != null && !parentNode.children.contains(node)) {
        parentNode.children.add(node);
      }
    } else if (node is Asset && node.locationId != null) {
      var locationNode = nodeMap[node.locationId];
      if (locationNode != null && !locationNode.children.contains(node)) {
        locationNode.children.add(node);
      }
    }
  }

  return nodeMap;
}

int calculateTreeHeight(Map<String, Base> nodes) {
  int maxHeight = 0;

  for (var node in nodes.values) {
    if (node.parentId == null) {
      int height = calculateNodeHeight(node);
      if (height > maxHeight) {
        maxHeight = height;
      }
    }
  }

  return maxHeight;
}

int calculateNodeHeight(Base node) {
  if (node.children.isEmpty) {
    return 1;
  }

  int maxChildHeight = 0;
  for (var child in node.children) {
    int childHeight = calculateNodeHeight(child);
    if (childHeight > maxChildHeight) {
      maxChildHeight = childHeight;
    }
  }

  return 1 + maxChildHeight;
}

List<Base> filterTree(
    List<Base> nodes, String filterText, bool energy, bool alert) {
  List<Base> result = [];

  for (var node in nodes) {
    var filteredChildren = filterTree(node.children, filterText, energy, alert);
    if (_nodeMatchesFilter(node, filterText, energy, alert) ||
        filteredChildren.isNotEmpty) {
      var newNode = cloneNodeWithFilteredChildren(node, filteredChildren);
      result.add(newNode);
    }
  }

  return result;
}

bool _nodeMatchesFilter(Base node, String filterText, bool energy, bool alert) {
  if (energy && alert) {
    return (node.name.toLowerCase().contains(filterText.toLowerCase())) &&
        _isAlert(node) &&
        _isEnergy(node);
  } else if (energy) {
    return (node.name.toLowerCase().contains(filterText.toLowerCase())) &&
        _isEnergy(node);
  } else if (alert) {
    return (node.name.toLowerCase().contains(filterText.toLowerCase())) &&
        _isAlert(node);
  } else {
    return (node.name.toLowerCase().contains(filterText.toLowerCase()));
  }
}

bool _isEnergy(Base node) {
  if (node is Asset) {
    return node.sensorType == 'energy';
  } else {
    return false;
  }
}

bool _isAlert(Base node) {
  if (node is Asset) {
    return node.status == 'alert';
  } else {
    return false;
  }
}

Base cloneNodeWithFilteredChildren(Base node, List<Base> filteredChildren) {
  if (node is Location) {
    return Location(
      id: node.id,
      name: node.name,
      parentId: node.parentId,
    )..children = filteredChildren;
  } else if (node is Asset) {
    return Asset(
      id: node.id,
      name: node.name,
      locationId: node.locationId,
      parentId: node.parentId,
      sensorType: node.sensorType,
      status: node.status,
    )..children = filteredChildren;
  } else {
    return node;
  }
}
