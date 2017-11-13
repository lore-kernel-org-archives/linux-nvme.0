From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 21:48:43 +0200
Subject: kernel paging request error observed on initiator after 'nvmetcli
 clear' on target
In-Reply-To: <CY1PR12MB07742829BFFB4C80E113D58FBC2B0@CY1PR12MB0774.namprd12.prod.outlook.com>
References: <CY1PR12MB07745F65B8684865F1AB8EEABC470@CY1PR12MB0774.namprd12.prod.outlook.com>
 <CY1PR12MB0774E29B5A7C62813DD2F371BC500@CY1PR12MB0774.namprd12.prod.outlook.com>
 <188896fb-2be9-81fe-64d6-6e2c77be7a06@grimberg.me>
 <CY1PR12MB077466A1AA7B248815F95618BC560@CY1PR12MB0774.namprd12.prod.outlook.com>
 <CY1PR12MB07742829BFFB4C80E113D58FBC2B0@CY1PR12MB0774.namprd12.prod.outlook.com>
Message-ID: <87e24002-7bd4-7830-df3c-8bd88feaf9f0@grimberg.me>


> Hi Sagi,
> 
> I have tried suggested API pci_alloc_irq_vectors (which is supposed to handle live cpu online/offline), but I could still see the issue.
> Let me know if I'm missing something.

Can you share where the the work item is generated from [1]?

It appears that iw_cm is receiving an event sometime after nvme-rdma
freed the tagset. Whats strange is that the endpoint free finds
completions since we should have properly drain the QP by then.

Can you maybe try and understand if we for some reason didn't
drain the offending qp?

[1]:
Call Trace:
  <IRQ>
  ? __ib_process_cq+0x5c/0xb0 [ib_core]
  ib_poll_handler+0x22/0x70 [ib_core]
  irq_poll_softirq+0x98/0xf0
  __do_softirq+0xd0/0x277
  do_softirq_own_stack+0x1c/0x30
  </IRQ>
  do_softirq+0x47/0x50
  __local_bh_enable_ip+0x57/0x60
  t4_ofld_send+0x10d/0x170 [cxgb4]
  cxgb4_remove_tid+0x93/0x110 [cxgb4]
  _c4iw_free_ep+0x58/0x110 [iw_cxgb4]
  close_con_rpl+0x9f/0x180 [iw_cxgb4]
  ? process_work+0x4f/0x60 [iw_cxgb4]
  ? skb_dequeue+0x59/0x70
  process_work+0x43/0x60 [iw_cxgb4]
  process_one_work+0x147/0x370
  worker_thread+0x4a/0x390
  kthread+0x109/0x140
  ? process_one_work+0x370/0x370
  ? kthread_park+0x60/0x60
  ret_from_fork+0x29/0x40
Code:  Bad RIP value.
RIP: 0xba30c00 RSP: ffff88087b6c3ee8
CR2: 000000000ba30c00
