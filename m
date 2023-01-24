Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C179C25B4E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+3NAYprDTW47i27HV9DulbYQse6ygZBWyRvZB/rMmI=; b=e2vqjAFN4NxiCbDCmQ5AFk0wKC
	GTTqtBwTns4gOPps0stC47K2nvE39Opt+Dl6faMp9nDIcByNY70nhflGMEnx3Q6ukfPtEwEH3KS4+
	GP/h6jxmasHSpoy8JlGjV6gl52+Sm8aolQsl2aT59qbnBwEP0yHwa0LqUws3QEbF02Zn7LD9fG56q
	W4rcHO7zUFa32DWfx+4iVyIJYe5YaK30e4UF1yL07RFqpyrUHtfS11OfjGpCr8FmIYbWlVtFoqRit
	4tBiH9hCMT+egwNF5QEqjbbDbPgwvv2KLC4LBYvy+HCrSJKoQmGiz/SRyDdXokRttf5DRpotl8TEu
	9xRhTeqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKPVC-00596D-4K; Tue, 24 Jan 2023 20:02:42 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKN26-004p3n-LO
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 17:24:32 +0000
Received: by mail-ed1-x530.google.com with SMTP id v5so19073333edc.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+3NAYprDTW47i27HV9DulbYQse6ygZBWyRvZB/rMmI=;
        b=jEC6Nh/tqAlOs1YSTJNTXawYL4iplyAKQ1+Ox77YL1oC20Gva7XXE/Nbwtdz0oUPCr
         RBKgbklB98Enb4CV5xtJRIxa+qXd8APCNjwyxJNju5qeFnTu5WF7O3eTdBJY+hsGjJPt
         MfMym4mNOSSdUQfVGR05sXZklkKIoCKtRHJewTaZaR+U/J1xvWL6sAwds55BpqH7vUCy
         DiU9CBQaip5bMm6Ng1ZSBuDfbBXex87btI61gTquUR9Mb33rm3RAPz72pGYcAaO4nkaF
         hBOS/mf2O4EwwrrcEsV4ILl779me2oIKsBLWKz/c1oOsKu4D73+AkVSlsbfY+q7kFMlk
         014A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+3NAYprDTW47i27HV9DulbYQse6ygZBWyRvZB/rMmI=;
        b=5tCFdH5D2KsgSUPHz5En6jS+SzwcpfWkd/wLOGsl3TV3BEZ279i/1bV3wWx4g3KmEU
         /DAxv8gLHQ8ifR2mdlcPqMhmS3HFn4k+qRxYxrM/MteLY/S0WWlxnpw2Dqh0EZAovn2r
         ncwO7C3Qh70AP/ekHpSJa35FOfgjwt7uMIxfM0Wdd2my6cE0ah7j8jkkKuNtVi9IGJzx
         PQ3TM/6c8MsqXdNwKRsA+X9R+D68t24Q9UDJijQ3gYDe3Efp3z6jN5X7EO3qhq4rv2cY
         IyDnBZIK3e3pbraZNvTEfBaapm4fkzahzf4yVkmyRWF6qvjkZ2KZQouwVKUzaVQinEZ2
         MEfg==
X-Gm-Message-State: AFqh2koeuHdO/sCq4VzcJ295ezinJ6Bq1EbDbcaH44MjLHbEf+0KSL/B
	KZtTqaf6JwIc96kqevEAdhj8QxupG51sF5iYClKX7A==
X-Google-Smtp-Source: AMrXdXs0A3a5ilJtJ5xoFKD38+amPLcQxUPH0fh0heymyKAbeGes5xoRUhQlkI7DyCA8Tf0NryPdXu/+2kcDTPfP6e8=
X-Received: by 2002:aa7:c681:0:b0:461:e3f2:38bc with SMTP id
 n1-20020aa7c681000000b00461e3f238bcmr3847518edq.149.1674581061787; Tue, 24
 Jan 2023 09:24:21 -0800 (PST)
MIME-Version: 1.0
From: Julien Bachmann <jbachmann@google.com>
Date: Tue, 24 Jan 2023 18:24:10 +0100
Message-ID: <CAB_p7=joH8PxzkMfVxs2Gd_BefF1_H9Vd3rvP0iaEwGAM0DpeA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
To: thomas.lendacky@amd.com
Cc: David.Kaplan@amd.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Peter Gonda <pgonda@google.com>, Marios Pomonis <pomonis@google.com>, sagi@grimberg.me, 
	Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_092430_723669_C63B037D 
X-CRM114-Status: GOOD (  32.78  )
X-Mailman-Approved-At: Tue, 24 Jan 2023 12:02:40 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/02/20 07:31 PM, Tom Lendacky wrote:
> On 11/30/20 12:50 PM, Tom Roeder wrote:
>> On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>>> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>>>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>>>> in non-DMA memory instead of depending on descriptors stored in DMA
>>>> memory. This change is needed under the malicious-hypervisor threat
>>>> model assumed by the AMD SEV and Intel TDX architectures, which encryp=
t
>>>> guest memory to make it unreadable. Some versions of these architectur=
es
>>>> also make it cryptographically hard to modify guest memory without
>>>> detection.
>>>
>>> I don't think this is a useful threat model, and I've not seen a
>>> discussion on lkml where we had any discussion on this kind of threat
>>> model either.
>>
>> Thanks for the feedback and apologies for the lack of context.
>>
>> I was under the impression that support for AMD SEV SNP will start showi=
ng
>> up in KVM soon, and my understanding of SNP is that it implies this thre=
at
>> model for the guest. See the patchset for SEV-ES, which is the generatio=
n
>> before SNP:
>> https://lkml.org/lkml/2020/9/14/1168.> This doesn't get quite to the SNP=
 threat model, but it starts to assume
>> more maliciousness on the part of the hypervisor.
>>
>> You can also see the talk from David Kaplan of AMD from the 2019 Linux
>> Security Summit for info about SNP:
>> https://www.youtube.com/watch?v=3Dyr56SaJ_0QI.
>>
>>
>>>
>>> Before you start sending patches that regress optimizations in various
>>> drivers (and there will be lots with this model) we need to have a
>>> broader discussion first.
>>
>> I've added Tom Lendacky and David Kaplan from AMD on the thread now, sin=
ce
>> I don't think I have enough context to say where this discussion should
>> take place or the degree to which they think it has or hasn't.
>>
>> Tom, David: can you please comment on this?
>
> Any discussion should certainly take place in the open on the mailing
> lists.
>
> Further information on SEV-SNP can be found on the SEV developer web page
> at https://developer.amd.com/sev.
>
> There is a white paper specific to SNP:
>   https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isol=
ation-with-integrity-protection-and-more.pdf
>
> Also, volume 2 of the AMD APM provides further information on the various
> SEV features (sections 15.34 to 15.36):
>   https://www.amd.com/system/files/TechDocs/24593.pdf
>
> It is a good idea to go through the various drivers and promote changes
> to provide protection from a malicious hypervisor, but, as Christoph
> states, it needs to be discussed in order to determine the best approach.

Following up on this thread as Confidential Computing (CC) gained more
popularity over the last 2 years. The host-to-guest threat model for
CC is more researched and discussed (e.g. Hardening Linux guest kernel
for CC at the Linux Plumbers Conference 2022 [1]).

Has a more general discussion on this threat model happened on the
lkml since then? Cloud providers, chip makers and academic researchers
[2] patched multiple drivers for host-to-guest vulnerabilities
following research.

>>> And HMB support, which is for low-end consumer devices that are usually
>>> not directly assigned to VMs aren't a good starting point for this.
>>
>> I'm glad to hear that this case doesn't apply directly to cases we would
>> care about for assignment to guests. I'm not very familiar with this
>> codebase, unfortunately. Do the same kinds of issues apply for the kinds
>> of devices that would be assigned to guests?

I=E2=80=99m also not familiar with this codebase but would it be possible f=
or
a malicious hypervisor to send a crafted vendor_id or device_id to
reach this code upon kernel=E2=80=99s PCI probing?

Would the patch now be acceptable with the development of CC or do you
see updates that should be made?

Let me know what you think and what would be the preferred next steps.

Best regards

[1] https://lpc.events/event/16/contributions/1328/
[2] Examples of research and patches
- https://arxiv.org/pdf/2109.10660.pdf
- https://lore.kernel.org/linux-hyperv/20201117105437.xbyjrs4m7garb2lj@liuw=
e-devbox-debian-v2/T/#t
- https://github.com/torvalds/linux/commit/5218e919c8d06279884aa0baf76778a6=
817d5b93

