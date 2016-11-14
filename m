From: rashika@amazon.com (Rashika Kheria)
Date: Mon, 14 Nov 2016 15:02:55 +0100
Subject: [PATCH] NVMe: Call nvme_pci_disable on error path of
 nvme_probe_work
In-Reply-To: <87lgwm42pd.fsf@linux.vnet.ibm.com>
References: <20161101152756.GA32044@ub8ca3ab5e3235612a6d0.ant.amazon.com>
 <20161112174133.GA10883@infradead.org>
 <62459369-5c23-8819-d360-58892b4ff1fc@amazon.com>
 <87lgwm42pd.fsf@linux.vnet.ibm.com>
Message-ID: <c2282dfa-f1f8-6a3e-4cdf-e91be378874a@amazon.com>


On 11/14/16 14:21, Gabriel Krisman Bertazi wrote:
> Rashika Kheria <rashika at amazon.com> writes:
>
>> Hi everyone,
>>
>> Could you please review the following patch? This solves a regression in
>> stable 4.4.y tree.
>>
>>
>> On 11/12/16 18:41, Christoph Hellwig wrote:
>>> Bouncing to Keith and linux-nvme
>>>
>>> On Tue, Nov 01, 2016@04:27:56PM +0100, Rashika Kheria wrote:
>>>> Commit d5537e988eec ("NVMe: Don't unmap controller registers on reset"),
>>>> introduced a regression in which it did not replace nvme_dev_unmap()
>>>> with nvme_pci_disable() in the error path of nvme_probe_work().
>>>>
> Hmm, the original commit had the same issue, which I think was fixed
> upstream by f58944e265d4 ("NVMe: Simplify device reset failure"), which
> was included in 4.5-rc7.  Isn't the upstream commit a better candidate
> for -stable?  It's a bit larger but the commit message says it may
> prevent other issues too.
>
I agree that the upstream commit does not have this issue. However, this 
patch does not apply cleanly on -stable 4.4 tree and might need 
ingestion of multiple other related patches. I am not sure if upstream 
is open to ingest patches other than bug fix in -stable branches.

-- 
Regards,
Rashika

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
