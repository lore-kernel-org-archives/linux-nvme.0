From: alex@zadara.com (Alex Lyakas)
Date: Wed, 5 Jun 2019 21:03:32 +0300
Subject: NULL pointer dereference in nvmet_rdma_queue_disconnect during bond
 failover
Message-ID: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>

Greetings NVMe community,

I am running kernel 5.1.6, which is the latest stable kernel.

I am testing a nvmf kernel target, configured on top of a bond interface, 
for high availability. The bond interface is created on top of two 
ConnectX-3 interfaces, which represent two ports of one ConnectX-3 VF (with 
this hardware a VF is dual-ported, i.e., a single VF yields two network 
interfaces). The bond is configured in active-backup mode. Exact bonding 
configuration is given in [1]. The nvmet target configuration doesn't have 
anything special and is given in [2].

I create a nvmf connection from a different machine to the nvmet target. 
Then I initiate bond failover, by disconnecting a cable that corresponds to 
the active bond slave. As a result, I get the following kernel panic:

[  268.036732] mlx4_en: b1s1: Link Down
[  268.036739] mlx4_en: b0s1: Link Down
[  268.036771] mlx4_en: b2s1: Link Down
[  268.138594] bebond: link status definitely down for interface b1s1, 
disabling it
[  268.138597] bebond: making interface b1s0 the new active one 53500 ms 
earlier
[  268.138671] RDMA CM addr change for ndev bebond used by id 
0000000019666fc8
[  268.138673] RDMA CM addr change for ndev bebond used by id 
000000007a8dd02e
[  268.138674] RDMA CM addr change for ndev bebond used by id 
00000000f825cc30
[  268.138675] RDMA CM addr change for ndev bebond used by id 
00000000c575ce3d
[  268.138733] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000148
[  268.138764] #PF error: [normal kernel read fault]
[  268.138782] PGD 0 P4D 0
[  268.138795] Oops: 0000 [#1] SMP PTI
[  268.138811] CPU: 1 PID: 869 Comm: kworker/u4:5 Not tainted 
5.1.6-050106-generic #201905311031
[  268.138839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.10.2-1ubuntu1 04/01/2014
[  268.138885] Workqueue: rdma_cm cma_ndev_work_handler [rdma_cm]
[  268.138912] RIP: 0010:nvmet_rdma_queue_disconnect+0x19/0x80 [nvmet_rdma]
[  268.138937] Code: e8 bc fe ff ff e9 68 ff ff ff 0f 1f 80 00 00 00 00 66 
66 66 66 90 55 48 89 e5 53 48 89 fb 48 c7 c7 80 10 86 c0 e8 57 1d ff d1 <48> 
8b 93 48 01 00 00 48 8d 83 48 01 00 00 48 39 d0 74 3a 48 8b 8b
[  268.139020] RSP: 0018:ffffb28a0111be08 EFLAGS: 00010246
[  268.139712] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[  268.140348] RDX: ffff9cc2a7c15c00 RSI: 000000000000000e RDI: 
ffffffffc0861080
[  268.140764] RBP: ffffb28a0111be10 R08: ffff9cc2a7c15c00 R09: 
000000000000008c
[  268.141195] R10: 00000000000001ed R11: 0000000000000001 R12: 
ffff9cc2a7c54aa8
[  268.141616] R13: ffff9cc2a9b55800 R14: ffff9cc2a7c54a80 R15: 
0ffff9cc2a78ee60
[  268.142057] FS:  0000000000000000(0000) GS:ffff9cc2b9b00000(0000) 
knlGS:0000000000000000
[  268.142520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  268.142962] CR2: 0000000000000148 CR3: 00000001afe30004 CR4: 
00000000000606e0
[  268.143430] Call Trace:
[  268.143880]  nvmet_rdma_cm_handler+0x94/0x292 [nvmet_rdma]
[  268.144343]  cma_ndev_work_handler+0x45/0xb0 [rdma_cm]
[  268.144792]  process_one_work+0x20f/0x410
[  268.145246]  worker_thread+0x34/0x400
[  268.145689]  kthread+0x120/0x140
[  268.146141]  ? process_one_work+0x410/0x410
[  268.146595]  ? __kthread_parkme+0x70/0x70
[  268.147045]  ret_from_fork+0x35/0x40

This is 100% reproducible.

Thanks,
Alex.

[1]
echo +bebond >/sys/class/net/bonding_masters
echo "1" > /proc/sys/net/ipv6/conf/bebond/disable_ipv6
echo "1" > /sys/class/net/bebond/bonding/mode
echo "100" > /sys/class/net/bebond/bonding/miimon
echo "1" > /sys/class/net/bebond/bonding/fail_over_mac
echo "60000" > /sys/class/net/bebond/bonding/updelay
ifconfig b1s1 down
echo "+b1s1" > /sys/class/net/bebond/bonding/slaves
ifconfig b1s0 down
echo "+b1s0" > /sys/class/net/bebond/bonding/slaves
echo "b1s1" > /sys/class/net/bebond/bonding/primary
ip addr add 10.3.3.23/24 dev bebond

[2]
mkdir /sys/kernel/config/nvmet/subsystems/volume-55555555
echo 1 > 
/sys/kernel/config/nvmet/subsystems/volume-55555555/attr_allow_any_host
echo 000055555555 > 
/sys/kernel/config/nvmet/subsystems/volume-55555555/attr_serial
mkdir /sys/kernel/config/nvmet/subsystems/volume-55555555/namespaces/1
echo 0977dff3-6885-43b3-a948-000055555555 > 
/sys/kernel/config/nvmet/subsystems/volume-55555555/namespaces/1/device_uuid
echo -n /dev/loop0 > 
/sys/kernel/config/nvmet/subsystems/volume-55555555/namespaces/1/device_path
echo 1 > 
/sys/kernel/config/nvmet/subsystems/volume-55555555/namespaces/1/enable

mkdir /sys/kernel/config/nvmet/ports/1
echo -n "ipv4" > /sys/kernel/config/nvmet/ports/1/addr_adrfam
echo -n "rdma" > /sys/kernel/config/nvmet/ports/1/addr_trtype
echo -n  10.3.3.23 > /sys/kernel/config/nvmet/ports/1/addr_traddr
echo -n 4420 > /sys/kernel/config/nvmet/ports/1/addr_trsvcid
ln -s /sys/kernel/config/nvmet/subsystems/volume-55555555 
/sys/kernel/config/nvmet/ports/1/subsystems/
