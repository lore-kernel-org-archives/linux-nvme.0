From: hare@suse.de (Hannes Reinecke)
Date: Fri, 15 Feb 2019 12:20:29 +0100
Subject: [PATCHv3] nvmetcli: ANA configuration support
Message-ID: <20190215112029.18602-1-hare@suse.de>

Add support for ANA configuration.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvmet/__init__.py |   2 +-
 nvmet/nvme.py     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 nvmetcli          |  64 +++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index 6542d87..ca05de4 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1 +1 @@
-from .nvme import Root, Subsystem, Namespace, Port, Host, Referral
+from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup
diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 7ab0846..0647ddc 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -566,6 +566,24 @@ class Namespace(CFSNode):
     def _get_nsid(self):
         return self._nsid
 
+    def _get_grpid(self):
+        self._check_self()
+        _grpid = 0
+        path = "%s/ana_grpid" % self.path
+        if os.path.isfile(path):
+            with open(path, 'r') as file_fd:
+                _grpid = int(file_fd.read().strip())
+        return _grpid
+
+    def set_grpid(self, grpid):
+        self._check_self()
+        path = "%s/ana_grpid" % self.path
+        if os.path.isfile(path):
+            with open(path, 'w') as file_fd:
+                file_fd.write(str(grpid))
+
+    grpid = property(_get_grpid, doc="Get the ANA Group ID.")
+
     subsystem = property(_get_subsystem,
                          doc="Get the parent Subsystem object.")
     nsid = property(_get_nsid, doc="Get the NSID as an int.")
@@ -589,10 +607,13 @@ class Namespace(CFSNode):
             return
 
         ns._setup_attrs(n, err_func)
+        if 'ana_grpid' in n:
+            ns.set_grpid(int(n['ana_grpid']))
 
     def dump(self):
         d = super(Namespace, self).dump()
         d['nsid'] = self.nsid
+        d['ana_grpid'] = self.grpid
         return d
 
 
@@ -652,6 +673,8 @@ class Port(CFSNode):
         self._check_self()
         for s in self.subsystems:
             self.remove_subsystem(s)
+        for a in self.ana_groups:
+            a.delete()
         for r in self.referrals:
             r.delete()
         super(Port, self).delete()
@@ -664,10 +687,19 @@ class Port(CFSNode):
     referrals = property(_list_referrals,
                          doc="Get the list of Referrals for this Port.")
 
+    def _list_ana_groups(self):
+        self._check_self()
+        if os.path.isdir("%s/ana_groups/" % self._path):
+            for d in os.listdir("%s/ana_groups/" % self._path):
+                yield ANAGroup(self, int(d), 'lookup')
+
+    ana_groups = property(_list_ana_groups,
+                          doc="Get the list of ANA Groups for this Port.")
+
     @classmethod
     def setup(cls, root, n, err_func):
         '''
-        Set up a Namespace object based upon n dict, from saved config.
+        Set up a Port object based upon n dict, from saved config.
         Guard against missing or bad dict items, but keep going.
         Call 'err_func' for each error.
         '''
@@ -685,6 +717,8 @@ class Port(CFSNode):
         port._setup_attrs(n, err_func)
         for s in n.get('subsystems', []):
             port.add_subsystem(s)
+        for a in n.get('ana_groups', []):
+            ANAGroup.setup(port, a, err_func)
         for r in n.get('referrals', []):
             Referral.setup(port, r, err_func)
 
@@ -692,6 +726,7 @@ class Port(CFSNode):
         d = super(Port, self).dump()
         d['portid'] = self.portid
         d['subsystems'] = self.subsystems
+        d['ana_groups'] = [a.dump() for a in self.ana_groups]
         d['referrals'] = [r.dump() for r in self.referrals]
         return d
 
@@ -747,6 +782,75 @@ class Referral(CFSNode):
         return d
 
 
+class ANAGroup(CFSNode):
+    '''
+    This is an interface to a NVMe ANA Group in configFS.
+    '''
+
+    MAX_GRPID = 1024
+
+    def __repr__(self):
+        return "<ANA Group %d>" % self.grpid
+
+    def __init__(self, port, grpid, mode='any'):
+        super(ANAGroup, self).__init__()
+
+        if not os.path.isdir("%s/ana_groups" % port.path):
+            raise CFSError("ANA not supported")
+
+        if grpid is None:
+            if mode == 'lookup':
+                raise CFSError("Need grpid for lookup")
+
+            grpids = [n.grpid for n in port.ana_groups]
+            for index in xrange(2, self.MAX_GRPID + 1):
+                if index not in grpids:
+                    grpid = index
+                    break
+            if grpid is None:
+                raise CFSError("All ANA Group IDs 1-%d in use" % self.MAX_GRPID)
+        else:
+            grpid = int(grpid)
+            if grpid < 1 or grpid > self.MAX_GRPID:
+                raise CFSError("GRPID %d must be 1 to %d" % (grpid, self.MAX_GRPID))
+
+        self.attr_groups = ['ana']
+        self._port = port
+        self._grpid = grpid
+        self._path = "%s/ana_groups/%d" % (self._port.path, self.grpid)
+        self._create_in_cfs(mode)
+
+    def _get_grpid(self):
+        return self._grpid
+
+    grpid = property(_get_grpid, doc="Get the ANA Group ID.")
+
+    @classmethod
+    def setup(cls, port, n, err_func):
+        '''
+        Set up an ANA Group object based upon n dict, from saved config.
+        Guard against missing or bad dict items, but keep going.
+        Call 'err_func' for each error.
+        '''
+
+        if 'grpid' not in n:
+            err_func("'grpid' not defined for ANA Group")
+            return
+
+        try:
+            a = ANAGroup(port, n['grpid'])
+        except CFSError as e:
+            err_func("Could not create ANA Group object: %s" % e)
+            return
+
+        a._setup_attrs(n, err_func)
+
+    def dump(self):
+        d = super(ANAGroup, self).dump()
+        d['grpid'] = self.grpid
+        return d
+
+
 class Host(CFSNode):
     '''
     This is an interface to a NVMe Host in configFS.
diff --git a/nvmetcli b/nvmetcli
index 8242364..3d8c16e 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -261,6 +261,16 @@ class UINamespaceNode(UINode):
                 raise configshell.ExecutionError(
                     "The Namespace could not be disabled.")
 
+    def ui_command_grpid(self, grpid):
+        '''
+        Sets the ANA Group ID of the current Namespace to I{grpid}
+        '''
+        try:
+            self.cfnode.set_grpid(grpid)
+        except Exception as e:
+            raise configshell.ExecutionError(
+                "Failed to set ANA Group ID for this Namespace.")
+
     def summary(self):
         info = []
         info.append("path=" + self.cfnode.get_attr("device", "path"))
@@ -270,6 +280,8 @@ class UINamespaceNode(UINode):
         ns_nguid = self.cfnode.get_attr("device", "nguid")
         if ngiud_set(ns_nguid):
             info.append("nguid=" + ns_nguid)
+        if self.cfnode.grpid != 0:
+            info.append("grpid=" + str(self.cfnode.grpid))
         info.append("enabled" if self.cfnode.get_enable() else "disabled")
         ns_enabled = self.cfnode.get_enable()
         return (", ".join(info), True if ns_enabled == 1 else ns_enabled)
@@ -385,6 +397,12 @@ class UIPortNode(UINode):
     def __init__(self, parent, cfnode):
         UINode.__init__(self, str(cfnode.portid), parent, cfnode)
         UIPortSubsystemsNode(self)
+        try:
+            next(cfnode.ana_groups)
+        except StopIteration:
+            pass
+        else:
+            UIANAGroupsNode(self)
         UIReferralsNode(self)
 
     def summary(self):
@@ -558,6 +576,52 @@ class UIReferralNode(UINode):
                     "The Referral could not be disabled.")
 
 
+class UIANAGroupsNode(UINode):
+    def __init__(self, parent):
+        UINode.__init__(self, 'ana_groups', parent)
+
+    def refresh(self):
+        self._children = set([])
+        for a in self.parent.cfnode.ana_groups:
+            UIANAGroupNode(self, a)
+
+    def ui_command_create(self, grpid):
+        '''
+        Creates a new ANA Group.
+
+        SEE ALSO
+        ========
+        B{delete}
+        '''
+        a = nvme.ANAGroup(self.parent.cfnode, grpid, mode='create')
+        UIANAGroupNode(self, a)
+
+    def ui_command_delete(self, grpid):
+        '''
+        Deletes the ANA Group with the specified I{name}.
+
+        SEE ALSO
+        ========
+        B{create}
+        '''
+        a = nvme.ANAGroup(self.parent.cfnode, grpid, mode='lookup')
+        a.delete()
+        self.refresh()
+
+
+class UIANAGroupNode(UINode):
+    ui_desc_ana = {
+        'state' : ('string', 'ANA state'),
+    }
+
+    def __init__(self, parent, cfnode):
+        UINode.__init__(self, str(cfnode.grpid), parent, cfnode)
+
+    def summary(self):
+        info = []
+        info.append("state=" + self.cfnode.get_attr("ana", "state"))
+        return (", ".join(info), True)
+
 class UIHostsNode(UINode):
     def __init__(self, parent):
         UINode.__init__(self, 'hosts', parent)
-- 
2.13.7
