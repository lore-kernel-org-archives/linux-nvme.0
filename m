From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 11 Aug 2016 12:01:59 +0300
Subject: [PATCH RFC 1/4] fabrics: define admin sqsize min default, per spec
In-Reply-To: <1470888438-823-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <be1a6027-04f5-815d-ba2a-89529087dab4@grimberg.me>



On 11/08/16 07:07, Jay Freyensee wrote:
> Upon admin queue connect(), the rdma qp was being
> set based on NVMF_AQ_DEPTH.  However, the fabrics layer was
> using the sqsize field value set for I/O queues for the admin
> queue, which through the nvme layer and rdma layer off-whack:
>
> root at fedora23-fabrics-host1 nvmf]# dmesg
> [ 3507.798642] nvme_fabrics: nvmf_connect_admin_queue():admin sqsize
> being sent is: 128
> [ 3507.798858] nvme nvme0: creating 16 I/O queues.
> [ 3507.896407] nvme nvme0: new ctrl: NQN "nullside-nqn", addr
> 192.168.1.3:4420
>
> Thus, to have a different admin queue value (which the fabrics
> spec states the minimum depth for a fabrics admin queue is 32 via
> the ASQSZ definition), we need also a new variable to hold
> the sqsize for admin fabrics queue.  This also allows fabric
> implementation layers to set an admin sqsize greater than the
> specification-defined minimum, which the fabrics spec allows.

We only need a variable if we actually have someone making use of
it with the non-default value. I honestly don't see the reason
to keep it in a variable when no one is making real use
of it.

If you would have exposed it to user-space then it would make
better sense (although I'm not a fan of adding not very useful
configs to user-space).
