From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Tue, 9 Jul 2019 22:47:12 +0000
Subject: Should hot removed devices close open namespace bd references?
In-Reply-To: <32a2e339-b948-43fe-72a3-77eb2e626c63@grimberg.me>
References: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>
 <32a2e339-b948-43fe-72a3-77eb2e626c63@grimberg.me>
Message-ID: <4eddc7d98f49abf4255c31fbe4412ce9e3877c06.camel@intel.com>

Hi Sagi,

On Tue, 2019-07-09@13:09 -0700, Sagi Grimberg wrote:
> > Hello,
> > 
> > 5.2 shows a strange regression where if a namespace handle is open and
> > the device is hot removed, then hot inserted, the new controller
> > instance fails to enumerate.
> 
> This is due to 1b1031ca63b2 ("nvme: validate cntlid during controller 
> initialisation")
> 
> > Previous kernels back to the multipathing introduction would simply add
> > the new namespace to the previous controller's subsystem id, so you
> > would end up with something like:
> > /dev/nvme2
> > /dev/nvme0n2
> > Because the subsystem namespace instance is 2 upon enumeration as the
> > previous handle hadn't been released through the block layer.
> 
> Its the controller that is not released (as the open ns handle holds
> a reference to it). But what is the old controller state? the code
> is supposed to allow this check if the old controller is in
> DELETING/DEAD.
The state is 6 (DEAD). I added some sysfs code to show the controller
state:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 120fb593d1da..9a81d9d3179d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2314,6 +2314,25 @@ static struct nvme_subsystem
*__nvme_find_get_subsystem(const char *subsysnqn)
 	struct device_attribute subsys_attr_##_name = \
 		__ATTR(_name, _mode, _show, NULL)
 
+static ssize_t nvme_subsys_show_ctrls(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	struct nvme_ctrl *ctrl;
+	int count = 0;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		count += sprintf(buf, "%s: state %d\n",
+				 dev_name(ctrl->device), ctrl->state);
+	mutex_unlock(&nvme_subsystems_lock);
+
+	return count;
+}
+static SUBSYS_ATTR_RO(subsys_ctrls, S_IRUGO, nvme_subsys_show_ctrls);
+
 static ssize_t nvme_subsys_show_nqn(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -2345,6 +2364,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+	&subsys_attr_subsys_ctrls.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 #endif



Result:
root at deb:~# cat /sys/class/nvme-subsystem/nvme-subsys1/subsys_ctrls 
nvme1: state 6


> 
> > With 5.2, I instead see:
> > [  247.767504] nvme nvme2: pci function 10000:01:00.0
> > [  247.772642] nvme 10000:01:00.0: enabling device (0000 -> 0002)
> > [  247.778671] pcieport 10000:00:02.0: can't derive routing for PCI INT
> > A
> > [  247.785411] nvme 10000:01:00.0: PCI INT A: no GSI
> > [  247.899879] nvme nvme2: Duplicate cntlid 0 with nvme0, rejecting
> > [  247.906086] nvme nvme2: Removing after probe failure status: -22
> > 
> > 
> > Here's a test program:
> > #define _GNU_SOURCE
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > 
> > int main(int argc, char *argv[])
> > {
> >          int fd;
> > 
> >          fd = open("/dev/nvme0n1", O_DIRECT);
> > 
> >          for (;;)
> >                  ;
> > }
> > 
> > 
> > 
> > Run this and in parallel, remove the link from the upstream port:
> > setpci -s <BDF> CAP_EXP+10.w=10:10
> > And add it back:
> > setpci -s <BDF> CAP_EXP+10.w=0:10
> 
> If you wait a bit between these operations, does it work as expected?
It doesn't clear up.
If I attach gdb and close the file handle, then it clears up.



When I use manual hotplugs rather than link active control, I see the
controller instance still active in the subsystem:

root at deb:~# ll /sys/class/nvme-subsystem/nvme-subsys1/
total 0
-r--r--r-- 1 root root 4096 Jul  9 10:26 firmware_rev
-rw-r--r-- 1 root root 4096 Jul  9 10:26 iopolicy
-r--r--r-- 1 root root 4096 Jul  9 10:26 model
lrwxrwxrwx 1 root root    0 Jul  9 10:26 nvme1 ->
../../../pci0000:17/0000:17:05.5/pci10000:00/10000:00:03.0/10000:02:00.
0/nvme/nvme1
drwxr-xr-x 2 root root    0 Jul  9 10:26 power
-r--r--r-- 1 root root 4096 Jul  9 10:26 serial
-r--r--r-- 1 root root 4096 Jul  9 10:26 subsys_ctrls
-r--r--r-- 1 root root 4096 Jul  9 10:26 subsysnqn
lrwxrwxrwx 1 root root    0 Jul  9 10:26 subsystem ->
../../../../class/nvme-subsystem
-rw-r--r-- 1 root root 4096 Jul  9 10:24 uevent

root at deb:~# cat /sys/class/nvme-subsystem/nvme-subsys1/nvme1 
cat: /sys/class/nvme-subsystem/nvme-subsys1/nvme1: No such file or
directory



From what I see, the subsystem release function can't be called until
the controller and namespace reference is dropped. That seems fine
because the handle is still open (though dead), except that a new
insertion of the same device is now rejected. In old code, the lack of
subsystem release just meant you got weird naming.

Note this occurs with multipath=y and =n
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190709/189b7a79/attachment.bin>
