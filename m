Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3448FC71133
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SMTd5H5qqQtmPWNXMn/TNM4LkJu2c1q8wud1S29LIRU=; b=fVnd8aEze0opTJxgHtg6CXImcT
	T+LKsUNrSNEnC3Ir0hiFNh8nEm12XeLStcIrqC809309rl3G5ft3iODbui8op2tJnOcT3i3MZIK5H
	IcpChbUHi9BtybnBplZwRKcMVzebZ7He3i1kppIygHD9kWUnT7CZZOfyH61WE5VEHnx//F/HRu9lb
	J9mplvBlsSjOVFZI79v9mjLpifozFeB+L7lVEReei+oqyG8T6FMIqxE1TmfrFqLQ3SFGGL32hOPaV
	mBiDMk2FWzlAhLMNmqreFCApNxgZa36lpx4ud926gB/jZW4QvrF2xFeIdAUe+qy9GFw6GHp8sj2tb
	gzuc1h8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNmH-0000000ATHc-3PQ7;
	Wed, 11 Jun 2025 15:54:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPIs6-00000009df6-2jps
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 10:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SMTd5H5qqQtmPWNXMn/TNM4LkJu2c1q8wud1S29LIRU=; b=OY0082slzxoWHplEohLvxvS51O
	P2ISY5tRoKEzIs9MGYS7mdPKi6CTz5pXzriVAPySwi/ISgCLnihdxZPkZQPE4Ko062u9HoUjLn3Hk
	VXsKO5uaLgbJFlP9GqCQBGgKNZkFhTkmp2rcHoteMz8VoX4xTwvuoL4wPjxbgYC5U5P+nfQGv2As6
	NQ4Qy1Gky1eVQh/4yaTy5xuflPhjjzhmq3M77pRF5PrSjgPY/VepyI2saJJ/R8ex1XVyugkI4ryAo
	9PoAwGTAruktfm37sPgU+4D5p8YvxwiJl7RhENH97aBm7sUaBpfQHSTjuqZGTdWvzw11tCUymbjQ7
	Jjq82bmA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPIs3-00000002Hau-3suC
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 10:39:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8YHOF004759;
	Wed, 11 Jun 2025 10:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SMTd5H5qqQtmPWNXMn/TNM4LkJu2c1q8wud1S29LI
	RU=; b=l6I92Vq+M7dqDsaoRCQCVIUIe4hSn1I3PP97rDbCg9HU/0Ih0AiHStXDB
	erSvdP3gBTqF20jIIZ9YioHKLOkF8WShugiHMFhRfwtOIib21FmK7YAZZ4fQti2v
	d5660AutBNjQxtvaRjdXTO3qsi94VkzNuSXMCKHLFGM/iXoRKsqXcisdifM7aXbe
	CdP3bSrBTH3St0BfY7CetE3RZfSVdt+ZKvLvGGub8vvlXowtjIRemJyvtx9nKrSq
	ykakyLNFa+PiOr5H/MF6fHQmRWb66nHGohH1TSMKfCDL2GDcnJjqlS60QdKqOaLu
	4J+1TaQvP8QzS6m9pX467wLL8gT2A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3v30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:39:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8BKoh021905;
	Wed, 11 Jun 2025 10:39:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yybwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:39:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55BAdhlK51183916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 10:39:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455ED20043;
	Wed, 11 Jun 2025 10:39:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E3E120040;
	Wed, 11 Jun 2025 10:39:41 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.37.3])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 10:39:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, gjoyce@ibm.com
Subject: [PATCH] nvmetcli: add support for NVMe passthru target
Date: Wed, 11 Jun 2025 16:09:29 +0530
Message-ID: <20250611103939.3056458-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68495cf1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8 a=Txdbm_XWa9iR3vD8aRwA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4OCBTYWx0ZWRfX0YwNzSUZFhWk yPxTVmYOSnjt8xp3FLphgGAUR/4B5cwYH2dLQyoLaD477SEtBVrb/LlqNRS7AM/A/djrZYTn7Hf gezfHgDnv6yvSf86b9notB+zy0ucuddJ2V7XkHyqJX7NU/O7awOBpXhA/USoWUKB5yeG+X7nTko
 oY8dp3PK2jM7FUsRrpM+9iFM6+fJZo72FsBtlRluLIRco6VLrs9SFWZpIlFoxnhF7GjpAo6Pt71 /EnYI6v/ftq/rydJ+rxykjj3osy/t/9qWLbGKz43fImZ5+CF5AbhbeGewxT0+tSuBzbcWmuMSfS dh+pqs+trxkEJwF8saswmw7zgR6RzAzTNueyHgmhOw8Uqk2GbRNYtnx5gGtAq8rAxMN4/8HkcUg
 o9Tqi0kDbilkOEAUBVp346qpJTmyFZXatea9CV8HG/Sey2/g55wV57L10J8W3iANVR8IaTfk
X-Proofpoint-GUID: 5l1uphn7tQKUWEetfy7auAmofPgtzG9a
X-Proofpoint-ORIG-GUID: 5l1uphn7tQKUWEetfy7auAmofPgtzG9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_113952_298670_4B652423 
X-CRM114-Status: GOOD (  17.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This change adds the support for configuring NVMe passthru target.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvmet/__init__.py |   2 +-
 nvmet/nvme.py     | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 nvmetcli          |  77 ++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index cf172bd..5e2f525 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1,2 +1,2 @@
-from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup,\
+from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup, Passthru, \
     DEFAULT_SAVE_FILE
diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..d462ea2 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -462,6 +462,13 @@ class Subsystem(CFSNode):
     namespaces = property(_list_namespaces,
                           doc="Get the list of Namespaces for the Subsystem.")
 
+    def _get_passthru(self):
+        self._check_self()
+        return Passthru(self)
+
+    passthru = property(_get_passthru,
+                        doc="Get the passthru node for the subsystem")
+
     def _list_allowed_hosts(self):
         return [os.path.basename(name)
                 for name in os.listdir("%s/allowed_hosts/" % self._path)]
@@ -510,6 +517,8 @@ class Subsystem(CFSNode):
             Namespace.setup(s, ns, err_func)
         for h in t.get('allowed_hosts', []):
             s.add_allowed_host(h)
+        for pt in t.get('passthru', []):
+            Passthru.setup(s, pt, err_func)
 
         s._setup_attrs(t, err_func)
 
@@ -518,6 +527,7 @@ class Subsystem(CFSNode):
         d['nqn'] = self.nqn
         d['namespaces'] = [ns.dump() for ns in self.namespaces]
         d['allowed_hosts'] = self.allowed_hosts
+        d['passthru'] = [self.passthru.dump()]
         return d
 
 
@@ -629,6 +639,98 @@ class Namespace(CFSNode):
         d['ana_grpid'] = self.grpid
         return d
 
+class Passthru(CFSNode):
+    '''
+    This is an interface to a NVMe passthru in ConfigFS.
+    '''
+
+    def __init__(self, subsystem):
+        '''
+        @param subsystem: The parent Subsystem object.
+        @return: A Passthru object.
+        '''
+        super(Passthru, self).__init__()
+        self._path = "%s/passthru" % (subsystem.path)
+        self.attr_groups = ['device']
+
+    def _get_clear_ids(self):
+        self._check_self()
+        path = "%s/clear_ids" % self.path
+        _ids = 0
+        if os.path.isfile(path):
+            with open(path, 'r') as file_fd:
+                _ids = int(file_fd.read().strip())
+        return _ids
+
+    ids = property(_get_clear_ids,
+                   doc = "Get the passthru namespace clear_ids attribute.")
+
+    def set_clear_ids(self, clear):
+        self._check_self()
+        path = "%s/clear_ids" % self.path
+        if os.path.isfile(path):
+            with open(path, 'w') as file_fd:
+                file_fd.write(str(clear))
+
+    def _get_admin_timeout(self):
+        self._check_self()
+        path = "%s/admin_timeout" % self.path
+        _timeout = 0
+        if os.path.isfile(path):
+            with open(path, 'r') as file_fd:
+                _timeout = int(file_fd.read().strip())
+        return _timeout
+
+    admin_timeout = property(_get_admin_timeout,
+                   doc = "Get the passthru admin command timeout.")
+
+    def set_admin_timeout(self, timeout):
+        self._check_self()
+        path = "%s/admin_timeout" % self.path
+        if os.path.isfile(path):
+            with open(path, 'w') as file_fd:
+                file_fd.write(str(timeout))
+
+    def _get_io_timeout(self):
+        self._check_self()
+        path = "%s/io_timeout" % self.path
+        _timeout = 0
+        if os.path.isfile(path):
+            with open(path, 'r') as file_fd:
+                _timeout = int(file_fd.read().strip())
+        return _timeout
+
+    io_timeout = property(_get_io_timeout,
+                   doc = "Get the passthru IO command timeout.")
+
+    def set_io_timeout(self, timeout):
+        self._check_self()
+        path = "%s/io_timeout" % self.path
+        if os.path.isfile(path):
+            with open(path, 'w') as file_fd:
+                file_fd.write(str(timeout))
+
+    @classmethod
+    def setup(cls, subsys, p, err_func):
+        try:
+            pt = Passthru(subsys)
+        except CFSError as e:
+            err_func("Could not create Namespace object: %s" % e)
+            return
+        pt._setup_attrs(p, err_func)
+        if 'clear_ids' in p:
+            pt.set_clear_ids(int(p['clear_ids']))
+        if 'admin_timeout' in p:
+            pt.set_admin_timeout(int(p['admin_timeout']))
+        if 'io_timeout' in p:
+            pt.set_io_timeout(int(p['io_timeout']))
+
+    def dump(self):
+        d = super(Passthru, self).dump()
+        d['clear_ids'] = self.ids
+        d['admin_timeout'] = self.admin_timeout
+        d['io_timeout'] = self.io_timeout
+        return d
 
 class Port(CFSNode):
     '''
diff --git a/nvmetcli b/nvmetcli
index d949891..810a7cd 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -166,6 +166,7 @@ class UISubsystemNode(UINode):
         self._children = set([])
         UINamespacesNode(self)
         UIAllowedHostsNode(self)
+        UIPassthruNode(self)
 
     def summary(self):
         info = []
@@ -175,6 +176,82 @@ class UISubsystemNode(UINode):
         info.append("serial=" + self.cfnode.get_attr("attr", "serial"))
         return (", ".join(info), True)
 
+class UIPassthruNode(UINode):
+    ui_desc_device = {
+        'path' : ('string', 'Passthru device path')
+    }
+
+    def __init__(self, parent):
+        passthru = nvme.Passthru(parent.cfnode)
+        UINode.__init__(self, 'passthru', parent, passthru)
+
+    def refresh(self):
+        pass
+
+    def ui_command_enable(self):
+        if self.cfnode.get_enable():
+            self.shell.log.info("The passthru is already enabled.")
+        else:
+            try:
+                self.cfnode.set_enable(1)
+                self.shell.log.info("The passthru has been enabled.")
+            except Exception as e:
+                raise configshell.ExecutionError(
+                    "The passthru could not be enabled.")
+
+    def ui_command_disable(self):
+        if not self.cfnode.get_enable():
+            self.shell.log.info("The passthru is already disabled.")
+        else:
+            try:
+                self.cfnode.set_enable(0)
+                self.shell.log.info("The passthru has been disabled.")
+            except Exception as e:
+                raise configshell.ExecutionError(
+                    "The passthru could not be disabled.")
+
+    def ui_command_clear_ids(self, clear):
+        '''
+        If I{clear} is set to non-zero then clears the passthru namespace
+        unique identifiers EUI/GUID/UUID.
+        '''
+        try:
+            self.cfnode.set_clear_ids(clear)
+        except Exception as e:
+            raise configshell.ExecutionError(
+                "Failed to set clear_ids for this passthru target.")
+
+    def ui_command_admin_timeout(self, timeout):
+        '''
+        Sets the timeout of admin passthru command.
+        '''
+        try:
+            self.cfnode.set_admin_timeout(timeout)
+        except Exception as e:
+            raise configshell.ExecutionError(
+                "Failed to set the admin passthru command timeout.")
+
+    def ui_command_io_timeout(self, timeout):
+        '''
+        Sets the timeout of IO passthru command.
+        '''
+        try:
+            self.cfnode.set_io_timeout(timeout)
+        except Exception as e:
+            raise configshell.ExecutionError(
+                "Failed to set the IO passthru command timeout.")
+
+    def summary(self):
+        info = []
+        info.append("path=" + self.cfnode.get_attr("device", "path"))
+        if self.cfnode.ids != 0:
+            info.append("clear_ids=" + str(self.cfnode.ids))
+        if self.cfnode.admin_timeout != 0:
+            info.append("admin_tomeout=" + str(self.cfnode.admin_timeout))
+        if self.cfnode.io_timeout != 0:
+            info.append("io_tomeout=" + str(self.cfnode.io_timeout))
+        info.append("enabled" if self.cfnode.get_enable() else "disabled")
+        return (", ".join(info), True)
 
 class UINamespacesNode(UINode):
     def __init__(self, parent):
-- 
2.49.0


