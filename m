From: skaushal.lk@gmail.com (shubham k)
Date: Thu, 7 Jun 2018 16:28:47 +0530
Subject: nvme-oF: discover issue on multi-target mesh setup
Message-ID: <CAHLvXOatHGokYY7gdUZu9j+4F3ua2X+qdJ30DS7A4ATUKHixHg@mail.gmail.com>

Hello Guru(s),

NVMEoF (ROCEv2) Full-mesh Multi-Target Configuration

Let us consider one target and one initiator each with two interfaces.
In the setup from initiator ports both target ports are visible and
pingable, both with the TCP / IP stack or the RDMA stack. However, when I
use multiport target topology I see discovery and connect issues in
locating the remote NVME SSDs.
Suppose that I have exported one nvme device from interface A of the
target. Similarly, assume that on the B interface of the target I have
exported one nvme device. Then I am not able to discover the nvme devices
from either one interface, or both interfaces, of the initiator.
If I simplify the above topology so that the criss-cross IP routes are
removed, then NVME discovery and connection proceed flawlessly.

Discover command used with IPV4 addressing:

sudo nvme discover -t <transport_type> -traddr <transport_address>
-trsvcid=<port number> -w <host interface>

Debugging of the issue:

When discover command fails on the initiator with following error:

       Failed to write to /dev/nvme-fabrics: Connection timed out

on the target dmesg log following error is seen:

      nvmet_rdma: rdma_accept failed (error code = -101)

Problem statement:
    Root cause the reason for rdma_accept() failure.

I noticed that when I ran discover command there are 3 calls to
cm_work_handler(). In the first call to cm_work_handler() the error
-EHOSTUNREACH is thrown by ib_init_ah_from_wc(). The approx. call graph is:

cm_work_handler()->cm_req_handler()->cm_init_av_for_response()->
ib_init_ah_from_wc()

I noticed (with my printk) that cm_init_av_for_response() is not
checking for the error
returned by ib_init_ah_from_wc().

       [  +0.000016] shubham:ln=523:func=ib_init_ah_from_wc:ret=-113

Question:
    Please explain that why cm_init_av_for_response() is not
checking for returned error?

Later on down the line another error occurs in rdma_accept().

Question:
    Is this rdma_accept() error occurred because
cm_init_av_for_response() ignored the previous error returned by
ib_init_ah_from_wc() or some other issue? Please suggest.

In my debugging I have noticed that when rdma_accept() errors when
src_in->sa_family==10 in addr_resolve(), which belongs to IPV6 family. And
during successful discover command src_in->sa_family==2 in addr_resolve()
which belongs to IPV4 family.

I noticed that in __ib_cache_gid_get() the issue arises due to wrong
sgid_index leading to wrong gid. This sgid_index is present in struct
ib_qp_attr. The struct ib_qp_attr is extracted from struct rdma_cm_id
passed to rdma_accept().

3717 int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param
*conn_param)

Here is approx stack I ran through:
rdma_accept(){
 cma_modify_qp_rtr(){
  ib_modify_qp() {
   ib_modify_qp_with_udata() {
     ib_resolve_eth_dmac() {
       ib_query_gid() {
         ib_get_cached_gid() {
           _raw_read_lock_irqsave() {
             do_raw_read_lock();
           }
           __ib_cache_gid_get();

The struct rdma_cm_id lead to struct rdma_cm_id in rdma_accept().  And this
struct rdma_cm_id is extracted from struct work_struct passed to
cm_work_handler().

Machine details:
    Both NVMeOF host and NVMeOF target server is configured with
    Ubuntu OS  16.04.4 and kernel 4.14.7-041407-generic.
    NIC card (both target and host) - Mellanox Technologies
    MT27710 Family [ConnectX-4    Lx], driver: mlx5_core, firmware: 14.21.2010

Source code info:
URL: http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.14.7/
$git branch
* master
$git describe --tags --abbrev=0
cod/tip/daily/2018-03-15
$git checkout v4.14.7 -b ubuntu-4.14.7
Checking out files: 100% (20344/20344), done.
Switched to a new branch 'ubuntu-4.14.7'
$git describe --tags --abbrev=0
v4.14.7

After checkout I checked the commit id, it is same as mentioned in
above URL-page.

$git log|head
commit 3afae8437c3cbc22966762e80e81818f5a90eb06
Author: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Date:   Sun Dec 17 15:08:14 2017 +0100

    Linux 4.14.7

commit 7bc8eb30f1e02b4dd6fd2869720c64d9bf39d765
Author: Mauro Carvalho Chehab <mchehab at s-opensource.com>
Date:   Tue Nov 7 08:39:39 2017 -0500

Thanks in advance!!

Thanks & Regards,
Shubham
