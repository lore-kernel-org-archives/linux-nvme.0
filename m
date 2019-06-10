From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 10 Jun 2019 21:49:25 +0900
Subject: [RFC] mismatch between chardev and blkdev node names
Message-ID: <20190610124925.GA20319@minwooim-desktop>

Hi, NVMe people.

I'd like to get some advices for the reported issue from nvme-cli:
  https://github.com/linux-nvme/nvme-cli/issues/510

As all you guys know, the controller chardev is created with controller
instance id which is from ctrl->instance.  (e.g. /dev/nvme0)
For the namespace blkdev node is set to either instance id or
subsystem id when ns->head->disk is not there.

This policy can make the blkdev and chardev are pretty different view to
the users like who faced this issue.

For the following case, the controller and the namespaces are completly
looking different:

root at target:~# nvme list-subsys                                       
nvme-subsys0 - NQN=nqn.2014.08.org.nvmexpress:80861af4bar                 QEMU NVMe Ctrl
\                                                                                       
 +- nvme1 pcie 0000:00:05.0 live                                                        
nvme-subsys1 - NQN=nqn.2014.08.org.nvmexpress:80861af4foo                 QEMU NVMe Ctrl
\                                                                                       
 +- nvme0 pcie 0000:00:04.0 live                                                        
nvme-subsys2 - NQN=nqn.2014.08.org.nvmexpress:80861af4zoo                 QEMU NVMe Ctrl
\                                                                                       
 +- nvme2 pcie 0000:00:06.0 live                                                        

root at target:~# nvme list                                                                                                   
Node             SN                   Model                                    Namespace Usage                      Format           FW Rev  
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     bar                  QEMU NVMe Ctrl                           1         536.87  MB / 536.87  MB    512   B +  0 B   1.0     
/dev/nvme1n1     foo                  QEMU NVMe Ctrl                           1         536.87  MB / 536.87  MB    512   B +  0 B   1.0     
/dev/nvme2n1     zoo                  QEMU NVMe Ctrl                           1         536.87  MB / 536.87  MB    512   B +  0 B   1.0     

This example shows that if we want to get the same result for the id-ctrl,
then we should:
  # nvme id-ctrl /dev/nvme1
  # nvme id-ctrl /dev/nvme0n1

Should users with multipath enabled know this situation well and do
something with perfect understanding this policy because they might be
administrator for the system?  or should the driver provide the same
index at least right next to "nvme" for the controller and namespaces?

I hope you guys can give some advices here :)

Thanks,
