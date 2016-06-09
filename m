From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 9 Jun 2016 06:24:59 -0700
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
Message-ID: <20160609132459.GA5105@infradead.org>

On Thu, Jun 09, 2016@11:18:03AM +0200, Marta Rybczynska wrote:
> Hello,
> I'm testing the nvme-fabrics patchset and I get a kernel stall or errors when running 
> nvme connect-all. Below you have the commands and kernel log I get when it outputs
> errors. I'm going to debug it further today.
> 
> The commands I run:
> 
> ./nvme discover -t rdma -a 10.0.0.3
> Discovery Log Number of Records 1, Generation counter 1
> =====Discovery Log Entry 0======
> trtype:  ipv4
> adrfam:  rdma
> nqntype: 2
> treq:    0
> portid:  2
> trsvcid: 4420
> subnqn:  testnqn
> traddr:  10.0.0.3
> rdma_prtype: 0
> rdma_qptype: 0
> rdma_cms:    0
> rdma_pkey: 0x0000
> 
> ./nvme connect -t rdma -n testnqn -a 10.0.0.3
> Failed to write to /dev/nvme-fabrics: Connection reset by peer
> 
> ./nvme connect-all -t rdma  -a 10.0.0.3
> <here the kernel crashes>
> 
> In the kernel log I have:
> [  591.484708] nvmet_rdma: enabling port 2 (10.0.0.3:4420)
> [  656.778004] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:a2e92078-7f9f-4b19-bb4f-4250599bdb14.
> [  656.778255] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.0.3:4420
> [  656.778573] nvmet_rdma: freeing queue 0
> [  703.195100] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:a2e92078-7f9f-4b19-bb4f-4250599bdb14.
> [  703.195339] nvme nvme1: creating 8 I/O queues.
> [  703.239462] rdma_rw_init_mrs: failed to allocated 128 MRs
> [  703.239498] failed to init MR pool ret= -12
> [  703.239541] nvmet_rdma: failed to create_qp ret= -12
> [  703.239582] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).

To get things working you should try a smaller queue size.  We actually
have an option for this in the kernel, but nvme-cli doesn't expose
it yet, so feel free to hardcode it.

Of course we've still got a real bug in the error handling..
