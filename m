From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Mon, 14 May 2018 17:46:23 +0000
Subject: Cannot Connect NVMeoF At Certain NR_IO_Queues Values
Message-ID: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>

I'm running Ubuntu 18.04 with the included 4.15.0 kernel and Mellanox CX4 NICs and Intel P4800X SSDs.  I'm using NVMe-CLI v1.5 and nvmetcli v0.6.

I am getting a connect failure even at a relatively moderate nr_io_queues value such as 8:

rsa at tppjoe01:~$ sudo nvme connect -t rdma -a 10.6.0.16 -i 8 -n NQN1
Failed to write to /dev/nvme-fabrics: Invalid cross-device link

However, it works just fine if I use a smaller value, such as 4:

rsa at tppjoe01:~$ sudo nvme connect -t rdma -a 10.6.0.16 -i 4 -n NQN1
rsa at tppjoe01:~$

Target side dmesg from a failed attached with -i 8:

[425470.899691] nvmet: creating controller 1 for subsystem NQN1 for NQN nqn.2014-08.org.nvmexpress:uuid:8d0ac789-9136-4275-a46c-8d1223c8fe84.
[425471.081358] nvmet: adding queue 1 to ctrl 1.
[425471.081563] nvmet: adding queue 2 to ctrl 1.
[425471.081758] nvmet: adding queue 3 to ctrl 1.
[425471.110059] nvmet_rdma: freeing queue 3
[425471.110946] nvmet_rdma: freeing queue 1
[425471.111905] nvmet_rdma: freeing queue 2
[425471.382128] nvmet_rdma: freeing queue 4
[425471.522836] nvmet_rdma: freeing queue 5
[425471.640105] nvmet_rdma: freeing queue 7
[425471.669427] nvmet_rdma: freeing queue 6
[425471.670107] nvmet_rdma: freeing queue 0
[425471.692922] nvmet_rdma: freeing queue 8

Initiator side dmesg from same attempt:

[862316.209664] nvme nvme1: creating 8 I/O queues.
[862316.391411] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[862316.406271] nvme nvme1: failed to connect queue: 4 ret=-18
[862317.026234] nvme nvme1: Reconnecting in 10 seconds...
[862327.049650] general protection fault: 0000 [#5] SMP PTI
[862327.061932] Modules linked in: ipmi_ssif nls_iso8859_1 intel_rapl skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass joydev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel input_leds intel_cstate intel_rapl_perf mei_me ioatdma mei lpc_ich shpchp ipmi_si ipmi_devintf ipmi_msghandler mac_hid acpi_pad acpi_power_meter sch_fq_codel ib_iser iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi nvmet_rdma nvmet nvme_rdma nvme_fabrics rdmavt rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ib_core ast igb ttm mlx5_core mlxfw drm_kms_helper dca hid_generic syscopyarea aesni_intel devlink i2c_algo_bit aes_x86_64
[862327.207417]  sysfillrect crypto_simd sysimgblt usbhid uas fb_sys_fops cryptd hid nvme ptp drm glue_helper fm10k usb_storage ahci nvme_core pps_core libahci wmi
[862327.237119] CPU: 13 PID: 25490 Comm: kworker/u305:1 Tainted: G      D          4.15.0-20-generic #21-Ubuntu
[862327.257259] Hardware name: Quanta Cloud Technology Inc. 2U4N system 20F08Axxxx/Single side, BIOS F08A2A12 10/02/2017
[862327.278963] Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
[862327.293033] RIP: 0010:nvme_rdma_alloc_queue+0x3c/0x190 [nvme_rdma]
[862327.306056] RSP: 0018:ffffb2370e58fe08 EFLAGS: 00010206
[862327.317177] RAX: 0000000000000000 RBX: 5d6e473123dc82a6 RCX: ffff89e9ae817c20
[862327.332105] RDX: ffffffffc057b600 RSI: ffffffffc057a3ab RDI: ffff89edaa897000
[862327.347028] RBP: ffffb2370e58fe28 R08: 000000000000024d R09: 0000000000000000
[862327.361950] R10: 0000000000000000 R11: 00000000003d0900 R12: ffff89edaa897000
[862327.376873] R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
[862327.391796] FS:  0000000000000000(0000) GS:ffff89e9af140000(0000) knlGS:0000000000000000
[862327.408628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[862327.420780] CR2: 00007f685314edd0 CR3: 0000000209a0a001 CR4: 00000000007606e0
[862327.435709] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[862327.450643] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[862327.465561] PKRU: 55555554
[862327.471641] Call Trace:
[862327.477191]  nvme_rdma_configure_admin_queue+0x22/0x2d0 [nvme_rdma]
[862327.490386]  nvme_rdma_reconnect_ctrl_work+0x27/0xd0 [nvme_rdma]
[862327.503061]  process_one_work+0x1de/0x410
[862327.511741]  worker_thread+0x32/0x410
[862327.519728]  kthread+0x121/0x140
[862327.526847]  ? process_one_work+0x410/0x410
[862327.535863]  ? kthread_create_worker_on_cpu+0x70/0x70
[862327.546632]  ret_from_fork+0x35/0x40
[862327.554446] Code: 89 e5 41 56 41 55 41 54 53 48 8d 1c c5 00 00 00 00 49 89 fc 49 89 c5 49 89 d6 48 29 c3 48 c7 c2 00 b6 57 c0 48 c1 e3 04 48 03 1f <48> 89 7b 18 48 8d 7b 58 c7 43 50 00 00 00 00 e8 c0 8f d5 f0 45
[862327.593340] RIP: nvme_rdma_alloc_queue+0x3c/0x190 [nvme_rdma] RSP: ffffb2370e58fe08
[862327.609350] ---[ end trace a27f36203ed33123 ]---

Some experimenting seems to show this problem isn't in somewhat older kernels (I previously ran 4.13.9 on Ubuntu 16.10 on the same system) and I can use larger nr_io_queues values like 16 and 32 there without a problem.  Is this a known issue?  Any other thoughts?  Thanks!

Here's the JSON used to set up the target side:

{
  "hosts": [],
  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "10.6.0.16",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "rdma"
      },
      "portid": 1,
      "referrals": [],
      "subsystems": [
        "NQN1",
        "NQN2",
        "NQN3",
        "NQN4"
      ]
    }
  ],
  "subsystems": [
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme1n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "NQN1"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme2n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "NQN2"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme3n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "NQN3"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme4n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "NQN4"
    }
  ]
}
