From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 1 Sep 2017 04:28:30 -0400 (EDT)
Subject: kernel NULL pointer at IP: nvmet_rdma_remove_one+0x35/0x90
 [nvmet_rdma] on 4.13.0-rc7
In-Reply-To: <1275272916.3645043.1504182837326.JavaMail.zimbra@redhat.com>
Message-ID: <1761958575.3831933.1504254510721.JavaMail.zimbra@redhat.com>

Hi
Here is one NULL pointer bug observed during reboot target server, let me if you need more info, thanks

Environment:
Link layer is mlx5_roce
Connected by switch
Firmware version:
[   13.447246] mlx5_core 0000:04:00.0: firmware version: 12.18.1000
[   14.347008] mlx5_core 0000:04:00.1: firmware version: 12.18.1000
[   15.080944] mlx5_core 0000:05:00.0: firmware version: 14.18.1000
[   15.924917] mlx5_core 0000:05:00.1: firmware version: 14.18.1000

Two servers both installed below Mellanox cards:
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
05:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
05:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]


Th reproducer is similar as bellow, it's not 100% and I totally reproduced 3 times, will update it once I got stable reproducer.
1. Target side: setup NVMeoF ROCE RDMA
2. Client side: connect the target
3. Client side: do IO background and reset operation for about 400 times
4. Target side: reboot the server
5. check the target console log.

Console log from target:
[ 1542.298398] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:00000000-0000-0000-0000-000000000000.
[ 1544.713943] nvmet: adding queue 1 to ctrl 1.
[ 1544.719177] nvmet: adding queue 2 to ctrl 1.
[ 1544.724314] nvmet: adding queue 3 to ctrl 1.
[ 1544.729447] nvmet: adding queue 4 to ctrl 1.
[ 1544.734588] nvmet: adding queue 5 to ctrl 1.
[ 1544.739735] nvmet: adding queue 6 to ctrl 1.
[ 1544.744860] nvmet: adding queue 7 to ctrl 1.
[ 1544.750004] nvmet: adding queue 8 to ctrl 1.
[ 1544.755145] nvmet: adding queue 9 to ctrl 1.
[ 1544.760290] nvmet: adding queue 10 to ctrl 1.
[ 1544.765505] nvmet: adding queue 11 to ctrl 1.
[ 1544.770703] nvmet: adding queue 12 to ctrl 1.
[ 1544.775931] nvmet: adding queue 13 to ctrl 1.
[ 1544.781148] nvmet: adding queue 14 to ctrl 1.
[ 1544.786387] nvmet: adding queue 15 to ctrl 1.
[ 1544.791674] nvmet: adding queue 16 to ctrl 1.
[ 1544.796919] nvmet: adding queue 17 to ctrl 1.
[ 1544.802172] nvmet: adding queue 18 to ctrl 1.
[ 1544.807416] nvmet: adding queue 19 to ctrl 1.
[ 1544.812647] nvmet: adding queue 20 to ctrl 1.
[ 1544.817882] nvmet: adding queue 21 to ctrl 1.
[ 1544.823080] nvmet: adding queue 22 to ctrl 1.
[ 1544.828313] nvmet: adding queue 23 to ctrl 1.
[ 1544.833550] nvmet: adding queue 24 to ctrl 1.
[ 1544.838790] nvmet: adding queue 25 to ctrl 1.
[ 1544.844029] nvmet: adding queue 26 to ctrl 1.
[ 1544.849224] nvmet: adding queue 27 to ctrl 1.
[ 1544.854453] nvmet: adding queue 28 to ctrl 1.
[ 1544.859648] nvmet: adding queue 29 to ctrl 1.
[ 1544.864851] nvmet: adding queue 30 to ctrl 1.
[ 1544.870037] nvmet: adding queue 31 to ctrl 1.
[ 1544.875229] nvmet: adding queue 32 to ctrl 1.
[ 1544.880458] nvmet: adding queue 33 to ctrl 1.
[ 1544.885657] nvmet: adding queue 34 to ctrl 1.
[ 1544.890844] nvmet: adding queue 35 to ctrl 1.
[ 1544.896078] nvmet: adding queue 36 to ctrl 1.
[ 1544.901272] nvmet: adding queue 37 to ctrl 1.
[ 1544.906470] nvmet: adding queue 38 to ctrl 1.
[ 1544.911679] nvmet: adding queue 39 to ctrl 1.
[ 1544.916881] nvmet: adding queue 40 to ctrl 1.
[  OK  ] Started Show Plymouth Reboot with kexec Screen.
[  OK  ] Stopped NTP client/server.
[  OK  ] Stopped Dynamic System Tuning Daemon.
[  OK  ] Stopped Login Service.
[  OK  ] Stopped Availability of block devices.
         Stopping Logout off all iSCSI sessions on shutdown...
[  OK  ] Stopped Logout off all iSCSI sessions on shutdown.
[  OK  ] Stopped target Network.
         Stopping Network Manager...
[  OK  ] Stopped Network Manager.
         Stopping D-Bus System Message Bus...
[  OK  ] Stopped D-Bus System Message Bus.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Sockets.
[  OK  ] Closed Open-iSCSI iscsiuio Socket.
[  OK  ] Closed RPCbind Server Activation Socket.
[  OK  ] Closed Open-iSCSI iscsid Socket.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice User and Session Slice.
[  OK  ] Closed D-Bus System Message Bus Socket.
[  OK  ] Stopped target System Initialization.
[[32[ 1837.195523] audit: type=1131 audit(1504182560.382:673): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=auditd comm="systemd" exe="/usr/l'
m  OK  ] Sto[ 1837.220088] audit: type=1131 audit(1504182560.407:674): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup com'
pped Setup Virtual Console.
  [ 1837.247015] audit: type=1131 audit(1504182560.433:675): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=rhel-import-state comm="systemd" exe'
       Stopping Setup Virtual Console...
[  OK  ] Stopped target Swap.
         Deactivating swap /dev/mapper/rhelaa_rdma--virt--02-swap...
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Apply Kernel Variables...
         Stopping Update UTMP about[ 1837.300635] audit: type=1131 audit(1504182560.487:676): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=rhe'
 System Boot/Shutdown...
[  OK  ] Stopped target Encrypted Volumes.
         Stopping Load/Save Random Seed...
[  OK  ] Stopped Update UTMP about System Boot/Shutdown.
[  OK  ] Stopped Load/Save Random Seed.
         Stopping Security Auditing Service...
[  OK  ] Stopped Security Auditing Service.
[  OK  ] Stopped Create Volatile Files and Directories.
         Stopping Create Volatile Files and Directories...
[  OK  ] Stopped Import network configuration from initramfs.
         Stopping Import network configuration from initramfs...
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped Configure read-only root support.
         Stopping Configure read-only root support...
         Unmounting Configuration File System...
         Unmounting /run/user/0...
         Unmounting /boot...
[  OK  ] Deactivated swap /dev/rhelaa_rdma-virt-02/swap.
[  OK  ] Deactivated swap /dev/disk/by-uuid/...5a1-bd0d-4abd-968b-8a4c5cea18f8.
[  OK  ] Deactivated swap /dev/disk/by-id/dm...kraTfFQdAhmFiEuwqy52J3AmIxfcp8p.
[  OK  ] Deactivated swap /dev/disk/by-id/dm-name-rhelaa_rdma--virt--02-swap.
[  OK  ] Deactivated swap /dev/dm-1.
[  OK  [ 1837.463566] audit: type=1131 audit(1504182560.650:677): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-remount-fs comm="system'
] Deactivated swap /dev/mapper/rhelaa_rdma--virt--02-swap.
[  OK  ] Failed unmounting /boot.
[  OK  ] Unmounted Configuration File System.
[  OK  ] Unmounted /run/user/0.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Stopped target Local[ 1837.518012] audit: type=1131 audit(1504182560.704:678): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-t'
 File Systems (Pre).
[ 1837.574585] audit: type=1131 audit(1504182560.761:679): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-monitor comm="systemd" exe="/usr/'
[ 1837.619838] audit: type=1131 audit(1504182560.806:680): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/'
[  OK  ] Stopped Remount Root and Kernel File Systems.
         Stopping Remount Root and Kernel File Systems...
         Stopping Monitoring of LVM2 mirrors... dmeventd or progress polling...
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
         Stopping LVM2 metadata daemon...
[  OK  ] Stopped LVM2 metadata daemon.
[  OK  ] Started Restore /run/initramfs.
[ 1838.046012] audit: type=1130 audit(1504182561.232:681): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracut-shutdown comm="systemd" exe="/u'
[  OK  ] Reached target Shutdown.
[ 1838.228417] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[ 1838.260073] systemd-journald[995]: Received SIGTERM from PID 1 (systemd-shutdow).
[ 1838.424285] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[ 1838.452437] systemd-shutdown[1]: Unmounting file systems.
[ 1838.499919] systemd-shutdown[1]: Unmounting /boot.
[ 1838.564406] XFS (sda1): Unmounting Filesystem
[ 1838.898437] systemd-shutdown[1]: All filesystems unmounted.
[ 1838.906560] systemd-shutdown[1]: Deactivating swaps.
[ 1838.913934] systemd-shutdown[1]: All swaps deactivated.
[ 1838.921481] systemd-shutdown[1]: Detaching loop devices.
[ 1838.929635] systemd-shutdown[1]: All loop devices detached.
[ 1838.937439] systemd-shutdown[1]: Detaching DM devices.
[ 1839.101876] shutdown: 8 output lines suppressed due to ratelimiting
[ 1839.162390] dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
[ 1839.343230] XFS (dm-0): Unmounting Filesystem
[ 1839.352076] dracut Warning: Unmounted /oldroot.
[ 1839.387198] dracut: Disassembling device-mapper devices
[ 1839.600143] lab-bridge: port 1(lom_1) entered disabled state
[ 1840.561698] kvm: exiting hardware virtualization
[ 1840.571916] mlx5_core 0000:05:00.1: Shutdown was called
[ 1843.534997] mlx5_3:wait_for_async_commands:732:(pid 3920): done with all pending requests
[ 1844.161690] mlx5_core 0000:05:00.0: Shutdown was called
[ 1844.297234] nvmet_rdma: Removing queue 1
[ 1844.304840] nvmet_rdma: Removing queue 0
[ 1844.310594] nvmet_rdma: freeing queue 1
[ 1844.316202] nvmet_rdma: Removing queue 2
[ 1844.316206] nvmet_rdma: freeing queue 0
[ 1844.321849] nvmet_rdma: Removing queue 3
[ 1844.321906] nvmet_rdma: freeing queue 2
[ 1844.327317] nvmet_rdma: Removing queue 4
[ 1844.327324] nvmet_rdma: freeing queue 3
[ 1844.332795] nvmet_rdma: Removing queue 5
[ 1844.332833] nvmet_rdma: freeing queue 4
[ 1844.338120] nvmet_rdma: Removing queue 6
[ 1844.338160] nvmet_rdma: freeing queue 5
[ 1844.343442] nvmet_rdma: Removing queue 7
[ 1844.343480] nvmet_rdma: freeing queue 6
[ 1844.348656] nvmet_rdma: Removing queue 8
[ 1844.348694] nvmet_rdma: freeing queue 7
[ 1844.353861] nvmet_rdma: Removing queue 9
[ 1844.353903] nvmet_rdma: freeing queue 8
[ 1844.358988] nvmet_rdma: Removing queue 10
[ 1844.359021] nvmet_rdma: freeing queue 9
[ 1844.364165] nvmet_rdma: Removing queue 11
[ 1844.364197] nvmet_rdma: freeing queue 10
[ 1844.369242] nvmet_rdma: Removing queue 12
[ 1844.369278] nvmet_rdma: freeing queue 11
[ 1844.374403] nvmet_rdma: Removing queue 13
[ 1844.374455] nvmet_rdma: freeing queue 12
[ 1844.379417] nvmet_rdma: Removing queue 14
[ 1844.379451] nvmet_rdma: freeing queue 13
[ 1844.384513] nvmet_rdma: Removing queue 15
[ 1844.384553] nvmet_rdma: freeing queue 14
[ 1844.389447] nvmet_rdma: Removing queue 16
[ 1844.389483] nvmet_rdma: freeing queue 15
[ 1844.394466] nvmet_rdma: Removing queue 17
[ 1844.394512] nvmet_rdma: freeing queue 16
[ 1844.399419] nvmet_rdma: Removing queue 18
[ 1844.399455] nvmet_rdma: freeing queue 17
[ 1844.404521] nvmet_rdma: Removing queue 19
[ 1844.404558] nvmet_rdma: freeing queue 18
[ 1844.409408] nvmet_rdma: Removing queue 20
[ 1844.409451] nvmet_rdma: freeing queue 19
[ 1844.414450] nvmet_rdma: Removing queue 21
[ 1844.414486] nvmet_rdma: freeing queue 20
[ 1844.419371] nvmet_rdma: Removing queue 22
[ 1844.419405] nvmet_rdma: freeing queue 21
[ 1844.424369] nvmet_rdma: Removing queue 23
[ 1844.424405] nvmet_rdma: freeing queue 22
[ 1844.429229] nvmet_rdma: Removing queue 24
[ 1844.429261] nvmet_rdma: freeing queue 23
[ 1844.434178] nvmet_rdma: Removing queue 25
[ 1844.434214] nvmet_rdma: freeing queue 24
[ 1844.439005] nvmet_rdma: Removing queue 26
[ 1844.439040] nvmet_rdma: freeing queue 25
[ 1844.443943] nvmet_rdma: Removing queue 27
[ 1844.443976] nvmet_rdma: freeing queue 26
[ 1844.448782] nvmet_rdma: Removing queue 28
[ 1844.448815] nvmet_rdma: freeing queue 27
[ 1844.453693] nvmet_rdma: Removing queue 29
[ 1844.453728] nvmet_rdma: freeing queue 28
[ 1844.458494] nvmet_rdma: Removing queue 30
[ 1844.458530] nvmet_rdma: freeing queue 29
[ 1844.463398] nvmet_rdma: Removing queue 31
[ 1844.463432] nvmet_rdma: freeing queue 30
[ 1844.468209] nvmet_rdma: Removing queue 32
[ 1844.468241] nvmet_rdma: freeing queue 31
[ 1844.473091] nvmet_rdma: Removing queue 33
[ 1844.473123] nvmet_rdma: freeing queue 32
[ 1844.477869] nvmet_rdma: Removing queue 34
[ 1844.477901] nvmet_rdma: freeing queue 33
[ 1844.482747] nvmet_rdma: Removing queue 35
[ 1844.482779] nvmet_rdma: freeing queue 34
[ 1844.487534] nvmet_rdma: Removing queue 36
[ 1844.487565] nvmet_rdma: freeing queue 35
[ 1844.492362] nvmet_rdma: Removing queue 37
[ 1844.492396] nvmet_rdma: freeing queue 36
[ 1844.497074] nvmet_rdma: Removing queue 38
[ 1844.497110] nvmet_rdma: freeing queue 37
[ 1844.501863] nvmet_rdma: Removing queue 39
[ 1844.501896] nvmet_rdma: freeing queue 38
[ 1844.506553] nvmet_rdma: Removing queue 40
[ 1844.506589] nvmet_rdma: freeing queue 39
[ 1844.511367] nvmet_rdma: freeing queue 40
[ 1847.685874] mlx5_2:wait_for_async_commands:732:(pid 3920): done with all pending requests
[ 1848.354287] mlx5_core 0000:04:00.1: Shutdown was called
[ 1848.360821] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[ 1848.370257] IP: nvmet_rdma_remove_one+0x35/0x90 [nvmet_rdma]
[ 1848.377282] PGD f16281067 
[ 1848.377283] P4D f16281067 
[ 1848.381004] PUD 103782e067 
[ 1848.384729] PMD 0 
[ 1848.388547] 
[ 1848.393853] Oops: 0000 [#1] SMP
[ 1848.398040] Modules linked in: nvmet_rdma nvmet null_blk sch_mqprio bridge 8021q garp mrp stp llc rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt tak
[ 1848.483926]  ahci libahci ptp libata crc32c_intel i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
[ 1848.495912] CPU: 7 PID: 3920 Comm: kexec Not tainted 4.13.0-rc7 #9
[ 1848.503958] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[ 1848.513473] task: ffff880f38cf1740 task.stack: ffffc90006b94000
[ 1848.521292] RIP: 0010:nvmet_rdma_remove_one+0x35/0x90 [nvmet_rdma]
[ 1848.529466] RSP: 0018:ffffc90006b97c58 EFLAGS: 00010287
[ 1848.536507] RAX: 0000000000000010 RBX: ffff880f15ea7200 RCX: ffff882028147b40
[ 1848.545717] RDX: ffff880f38cf1740 RSI: 0000000000000000 RDI: ffffffffa0668180
[ 1848.554949] RBP: ffffc90006b97c68 R08: 0000000000000000 R09: 000000000000876c
[ 1848.564208] R10: 00000000000003ff R11: 0000000000000001 R12: ffff8820328f0000
[ 1848.573461] R13: ffff8820328f0000 R14: ffff8820328f005c R15: ffff88102c4c5368
[ 1848.582718] FS:  00007f9a2a704740(0000) GS:ffff88207acc0000(0000) knlGS:0000000000000000
[ 1848.593109] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1848.600886] CR2: 0000000000000010 CR3: 0000000f30e8b000 CR4: 00000000001406e0
[ 1848.610227] Call Trace:
[ 1848.614360]  ib_unregister_device+0xd0/0x180 [ib_core]
[ 1848.621494]  mlx5_ib_remove+0x67/0x110 [mlx5_ib]
[ 1848.628090]  mlx5_detach_device+0xb7/0xc0 [mlx5_core]
[ 1848.635154]  mlx5_unload_one.isra.21+0x19d/0x1c0 [mlx5_core]
[ 1848.642949]  shutdown+0x55/0x170 [mlx5_core]
[ 1848.649152]  pci_device_shutdown+0x37/0x60
[ 1848.655187]  device_shutdown+0x13f/0x1e0
[ 1848.661015]  kernel_restart_prepare+0x36/0x40
[ 1848.667350]  kernel_kexec+0x14c/0x18b
[ 1848.672916]  SYSC_reboot+0x1e5/0x220
[ 1848.678375]  ? dentry_free+0x49/0x70
[ 1848.683914]  ? __dentry_kill+0x119/0x170
[ 1848.689782]  ? __getnstimeofday64+0x3b/0xd0
[ 1848.695951]  ? getnstimeofday64+0xe/0x20
[ 1848.701838]  ? __audit_syscall_entry+0xb3/0xf0
[ 1848.708295]  ? syscall_trace_enter+0x1d0/0x2b0
[ 1848.714740]  ? task_work_run+0x88/0xb0
[ 1848.720378]  SyS_reboot+0xe/0x10
[ 1848.725422]  do_syscall_64+0x67/0x150
[ 1848.730921]  entry_SYSCALL64_slow_path+0x25/0x25
[ 1848.737504] RIP: 0033:0x7f9a29ddaa56
[ 1848.742907] RSP: 002b:00007ffd57f7e5e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
[ 1848.752829] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9a29ddaa56
[ 1848.762288] RDX: 0000000045584543 RSI: 0000000028121969 RDI: fffffffffee1dead
[ 1848.771758] RBP: 0000000000000002 R08: 0000000000000005 R09: 00000000016b2ff0
[ 1848.781261] R10: 00007ffd57f7e300 R11: 0000000000000206 R12: 00007ffd57f7e868
[ 1848.790728] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[ 1848.800175] Code: 54 49 89 fc 48 c7 c7 80 81 66 a0 53 e8 05 5b 12 e1 48 8b 05 7e 3c 00 00 48 3d a0 81 66 a0 48 8d 98 c0 fe ff ff 74 1f 48 8b 43 20 <4c> 39 20 74 33 48 8b 83 40 01 0 
[ 1848.824195] RIP: nvmet_rdma_remove_one+0x35/0x90 [nvmet_rdma] RSP: ffffc90006b97c58
[ 1848.834168] CR2: 0000000000000010
[ 1848.839311] ---[ end trace 55fd71430389a364 ]---
[ 1848.877515] Kernel panic - not syncing: Fatal exception
[ 1848.884788] Kernel Offset: disabled
[ 1848.921045] ---[ end Kernel panic - not syncing: Fatal exception


Best Regards,
  Yi Zhang
