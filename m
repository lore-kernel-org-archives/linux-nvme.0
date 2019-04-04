From: solio.sarabia@intel.com (Solio Sarabia)
Date: Wed, 3 Apr 2019 17:38:04 -0700
Subject: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
Message-ID: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>

When two nvme devices are discrete-assigned [1] to a linuxvm on
hyper-v rs5 host, it fails to initialize both.  It worked a couple of
times and after some reboots it failed. `dmesg` shows:

[   13.941971] nvme nvme0: pci function 82c6:00:00.0
[   13.942802] nvme 82c6:00:00.0: can't derive routing for PCI INT A
[   13.942803] nvme 82c6:00:00.0: PCI INT A: no GSI
[   13.942844] nvme nvme1: pci function 8f8d:00:00.0
[   13.943397] nvme 8f8d:00:00.0: can't derive routing for PCI INT A
[   13.943399] nvme 8f8d:00:00.0: PCI INT A: no GSI
[   14.099310] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for interrupt failed: 0xc000009a
[   14.099353] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: Request for interrupt failed: 0xc000009a
[   14.119391] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: hv_irq_unmask() failed: 0x5
[   14.124416] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: hv_irq_unmask() failed: 0x5
[   74.932888] nvme nvme1: I/O 7 QID 0 timeout, completion polled
[   74.932893] nvme nvme0: I/O 3 QID 0 timeout, completion polled
[  136.372890] nvme nvme1: I/O 4 QID 0 timeout, completion polled
[  136.372892] nvme nvme0: I/O 20 QID 0 timeout, completion polled
[  136.373280] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: Request for interrupt failed: 0xc000009a
[  136.373432] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for interrupt failed: 0xc000009a
[  136.376262] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: hv_irq_unmask() failed: 0x5
[  136.376906] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: hv_irq_unmask() failed: 0x5
loop of 'interrupt failed' and 'hv_irq_unmask' calls
...

Device is intel ssd p4608 pci nvme, that consists of two nvme devices
as seen by linux (5.0.1-rc3).  Some info from `lspci -v`:

82c6:00:00.0 Non-Volatile memory controller: Intel Corporation Express Flash NVMe P4500/P4600 (prog-if 02 [NVM Express])
8f8d:00:00.0 Non-Volatile memory controller: Intel Corporation Express Flash NVMe P4500/P4600 (prog-if 02 [NVM Express])

Let me know if other info/logs are needed.

[1] https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/deploy/deploying-storage-devices-using-dda

Thanks,
-Solio
