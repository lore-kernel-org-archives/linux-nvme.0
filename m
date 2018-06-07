From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 11:57:09 +0200
Subject: [PATCH nvmetcli] ANA configuration support
Message-ID: <20180607095709.26738-1-hare@suse.de>

Add support for ANA configuration to nvmetcli.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvmet/nvme.py | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 nvmetcli      | 59 +++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 8253ea9..baf972c 100644
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
@@ -589,10 +607,12 @@ class Namespace(CFSNode):
             return
 
         ns._setup_attrs(n, err_func)
+        ns.set_grpid(int(n['ana_grpid']))
 
     def dump(self):
         d = super(Namespace, self).dump()
         d['nsid'] = self.nsid
+        d['ana_grpid'] = self.grpid
         return d
 
 
@@ -652,6 +672,8 @@ class Port(CFSNode):
         self._check_self()
         for s in self.subsystems:
             self.remove_subsystem(s)
+        for a in self.ana_groups:
+            a.delete()
         for r in self.referrals:
             r.delete()
         super(Port, self).delete()
@@ -664,6 +686,14 @@ class Port(CFSNode):
     referrals = property(_list_referrals,
                          doc="Get the list of Referrals for this Port.")
 
+    def _list_ana_groups(self):
+        self._check_self()
+        for d in os.listdir("%s/ana_groups/" % self._path):
+            yield ANA_Group(self, int(d), 'lookup')
+
+    ana_groups = property(_list_ana_groups,
+                          doc="Get the list of ANA Groups for this Port.")
+
     @classmethod
     def setup(cls, root, n, err_func):
         '''
@@ -685,6 +715,8 @@ class Port(CFSNode):
         port._setup_attrs(n, err_func)
         for s in n.get('subsystems', []):
             port.add_subsystem(s)
+        for a in n.get('ana_groups', []):
+            ANA_Group.setup(port, a, err_func)
         for r in n.get('referrals', []):
             Referral.setup(port, r, err_func)
 
@@ -692,6 +724,7 @@ class Port(CFSNode):
         d = super(Port, self).dump()
         d['portid'] = self.portid
         d['subsystems'] = self.subsystems
+        d['ana_groups'] = [a.dump() for a in self.ana_groups]
         d['referrals'] = [r.dump() for r in self.referrals]
         return d
 
@@ -747,6 +780,72 @@ class Referral(CFSNode):
         return d
 
 
+class ANA_Group(CFSNode):
+    '''
+    This is an interface to a NVMe ANA Group in configFS.
+    '''
+
+    MAX_GRPID = 128
+
+    def __repr__(self):
+        return "<ANA Group %d>" % self.grpid
+
+    def __init__(self, port, grpid, mode='any'):
+        super(ANA_Group, self).__init__()
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
+            a = ANA_Group(port, n['grpid'])
+        except CFSError as e:
+            err_func("Could not create ANA Group object: %s" % e)
+            return
+
+        a._setup_attrs(n, err_func)
+
+    def dump(self):
+        d = super(ANA_Group, self).dump()
+        d['grpid'] = self.grpid
+        return d
+
+
 class Host(CFSNode):
     '''
     This is an interface to a NVMe Host in configFS.
diff --git a/nvmetcli b/nvmetcli
index 6b102a2..5e4bd16 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -258,6 +258,16 @@ class UINamespaceNode(UINode):
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
@@ -267,6 +277,8 @@ class UINamespaceNode(UINode):
         ns_nguid = self.cfnode.get_attr("device", "nguid")
         if ngiud_set(ns_nguid):
             info.append("nguid=" + ns_nguid)
+        if self.cfnode.grpid != 0:
+            info.append("grpid=" + str(self.cfnode.grpid))
         info.append("enabled" if self.cfnode.get_enable() else "disabled")
         ns_enabled = self.cfnode.get_enable()
         return (", ".join(info), True if ns_enabled == 1 else ns_enabled)
@@ -378,6 +390,7 @@ class UIPortNode(UINode):
     def __init__(self, parent, cfnode):
         UINode.__init__(self, str(cfnode.portid), parent, cfnode)
         UIPortSubsystemsNode(self)
+        UIANAGroupsNode(self)
         UIReferralsNode(self)
 
     def summary(self):
@@ -539,6 +552,52 @@ class UIReferralNode(UINode):
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
+        a = nvme.ANA_Group(self.parent.cfnode, grpid, mode='create')
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
+        a = nvme.ANA_Group(self.parent.cfnode, grpid, mode='lookup')
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
2.13.6
