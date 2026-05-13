Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A71CD343F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=raam9DVb6nwGgVMeORu4BM/vz6+kYfQFafLG0g3ziek=; b=DyLak/xZ62+UIbz/oyi/WTiOES
	f7Q0r/GCeytrt7e5fym4ZR0gSPKatmFTAPwXWm/P4daqfy1/dPx4cOtqeNwbJJd1Ya3l+c3DTYA0y
	kxo1CIX+RKXKRQPAo0Q2t3WcsMgZeij9viqPMz86YTM0YKmqz7S/L4JQlCyfMa2VKpxNji4uv0J/j
	Ie8P/wCKOANTQPhJ84yxkY7+8xnK1rXR2OWLeDwpPEZvxzoSHn0zA9Cv5n/WobC+PM54QuFYDuvKk
	t6IBHiIxNC7ZxBU7mG1qIgAZwcXNNUT1ZpcSlWsRc/dBcXKGD2t37346IG3aoO4/SKWMuYG7nIsbc
	VqlVU4Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMzhS-00000000yLW-1YvD;
	Wed, 13 May 2026 02:51:54 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMzhQ-00000000yKs-0JhN
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 02:51:53 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-7dcc6feccd6so613390a34.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 19:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778640710; cv=none;
        d=google.com; s=arc-20240605;
        b=kg7+zsImNKUn1IyTusjvabLa84Nk9TH/12jOrY6d+q+m/mIeo4CV0Pkz1xHDyEec5A
         LFQxlZGJFcgd8Sdz3wbjeWqRTTntdTFFKVmv7a+z8DFdACs2pq4tX4w/EmQHZLRCc7td
         zllXmjPEz7lYrxP79TG+r6yLnmo7Pbx1LD+N/dFnySsAvvkWIRZ/jpck3TTmmZ+16S6k
         ZdYvLiO8pjVRVL87D279zJKgjPAuJgHkHAaHcL2fDRZUsFzeGRoQPpS+2bMdyZYCOg71
         GydyXfEnzk+zzyeWlsXCHJU4cCMB3NyZTlCrD5PYj0bYfQgJCRgVTCrMO6Nbw8tl2eJJ
         pTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raam9DVb6nwGgVMeORu4BM/vz6+kYfQFafLG0g3ziek=;
        fh=HiQZwIDS1I6pUeUWkG7QJJC4T5v8Hzl7MWpAO5yLba4=;
        b=O2mN3Cze5y1DQetrazZUYmNAYYJi1mcUWJp18ZUHjzzlaBJMF86kwzLoHaPFQ13/Vt
         bdGgpkstiwawfsIbG4J2J+oFW0SsJPSRUG4ArVj1c6pw/iREUyQ0jsdcq6ILKQDN7nZr
         dJiVw4zoGz5wpASofuGVVmdzJq2VKwYTWKGDu/kACQ+sOI3eGelEUrDzaKroCDbdFKMu
         TiW4IoQsqa10xWukI71QoV3MEnA8fWXPOvvcuDEBV/cGke15J3W636MyupZuwVVrIOWp
         T78xxrw3ILMA42nua2SE2kZEgd5WJ2kyjE8itkiCh0MwUA/1/FrfUtIjKiz7Y4jHY5eX
         IctA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778640710; x=1779245510; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raam9DVb6nwGgVMeORu4BM/vz6+kYfQFafLG0g3ziek=;
        b=CeNuiU4/4Q80BH2/S2vJpCbtwp5yIwqgjzvAOCnLXl0dnILKXgrWWDKHVQL1LMjuYD
         3s1CPhM/G/NEb9sdDGIGonp/nISWhoV1FWa+InSud+lkJ0HNThTvJxii5GL4d7agkFZl
         eCXdoxJaXpaNsJ4p/BRts67odJgUyoPo77UC2r8dxPcbDl8CyumkPF3gh8U0x80e1to+
         F5MmrtBKcWX27UfeCYJS6uxywIA3fklZ/i6MKXVzd5lA8jI/INk716YwhSuOT5C0et0/
         tZHLr8/k/LJX0lvffVTc8AZgO3nnf7XrT04ZL7XEV8wzr2+ZwexgITnpsLsjqsgSNqKN
         ywnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778640710; x=1779245510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raam9DVb6nwGgVMeORu4BM/vz6+kYfQFafLG0g3ziek=;
        b=ZY3owV2mYO9QN0ITPpT6eUh5QqAHJdr9ph/4L3aJL1rDvlkLgwUShj5ZqAhgTEU8VR
         yFOzr7OIslu868/0VdogVrVChMGuTUXqylmyFPPPqFk+sb4O59Qbj3+svRTRvjuLDQkh
         40sLPpAVS0dSy8mEmVkHjOKGVMJwIto1f7ou2MioCK0qf1MZ7STYBj9Zf1X6UDCLY/Ds
         5HTLB9ekNTDWwTZsTsFvkGQTudqgTEqhwEaOVwlqzvnn3978+QhTK0DcF9syD3jFF7NN
         LYM6zTzOoqPh3phhU81NgckLvK5U7gGATGku8Z/Uv10DPYTMouVjfO83HQnMSjMOAm7h
         4IEw==
X-Forwarded-Encrypted: i=1; AFNElJ+JSKllSBRyT6pz3TagA4xUanKnV313DdbARVErk04EiV6Uvak9YNY7mYT62I9wyyPsryBWHKMG2Ic5@lists.infradead.org
X-Gm-Message-State: AOJu0YymSEAu51ZhHTUI43LvKe3AUdN+wK/Li43t4vT4hWDwJv5xAB72
	bm90C1czszd4O9VPJ8pPCmIGeMJ9FmksmTpD8g8mV2lpUKaFYyA0MlybS97h1SjT9/RbRjUznUQ
	0XCgzYzpFS6nG8nSc9YUfBrpbwd/Js95jMoNKHD4MQQ==
X-Gm-Gg: Acq92OGFazmSKHp0GrTGdt03YuP8WtPx6UnXZcg0+eF9quh9m5oV2j9TzBmUbDL8Ozi
	u1GXNuhVt2oJQJ/LBY4nR9IEXIZJN/AAznTS8vkkMvw+yUnZn1xxW6mer7L8A1ZKD9fa/VyRV7W
	CQZRH90BXSwL6rHtlke76fFhwOf/Xd/IhNHvJduogTLhQtNE95e6Y1AbO+jvIkoKuihuI3iWMoQ
	6Jl3GVati51nZj0U6NlNRmX8GVQjLOSBvuX7BLXQJpgNKpTJQ8LGiBxD5zt/lkzZ23Ao67j0mU7
	2laqfiU46cV8iAWs+Q8=
X-Received: by 2002:a05:6808:640f:b0:479:ffcf:52e4 with SMTP id
 5614622812f47-482b2d823a2mr634406b6e.8.1778640710257; Tue, 12 May 2026
 19:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com>
 <yq18qams3re.fsf@ca-mkp.ca.oracle.com> <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
 <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com> <CADUfDZqkT4g3T6uE=hxt9J6JDMXbJt49rM7_Vgs3EBPdFeuuLw@mail.gmail.com>
 <CADUfDZq+BZ4Xn19TXH53NndDwDwMKm3xS8wSMnMtRsF7dWSyGg@mail.gmail.com> <yq11pfgxf9s.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq11pfgxf9s.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 19:51:39 -0700
X-Gm-Features: AVHnY4I5-V51JtkIh-Ssp6M4Sux20aXJQq6-7lAFZgFvHPFmHKstgGsa0VGqDxM
Message-ID: <CADUfDZoYNjMCnBwoHmH0pbdiacmQ+aJd=p0KYxad2UB-UJ9-MQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_195152_177822_294FE006 
X-CRM114-Status: GOOD (  41.02  )
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

On Tue, May 12, 2026 at 7:16=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> Sorry about the delay. Been away for a few weeks...
>
> >> So seems like patch 1 ("block: use integrity interval instead of
> >> sector as seed") doesn't need a Fixes tag. Still, I'm confused why
> >> the auto-integrity code bothers setting the seed to the sector number
> >> in the first place if it's going to be remapped later. Why not just
> >> leave the seed zeroed?
>
> It adds a bit of extra protection in the sense that it there is one more
> parameter that can be validated. The premise of the integrity
> infrastructure is that things in the two supplied buffers (data + PI) as
> well as the control path (bip in the block layer case plus the SCSI or
> NVMe command fields) all need to agree for the I/O to go through.
>
> It is valid to generate the PI starting with 0. But that is
> indistinguishable from "the seed value was not initialized".
>
> > I would appreciate a response here. Would you be okay with patch 1 if
> > the Fixes tags were dropped?
>
> I am afraid I still don't completely understand why things are broken.

Nothing is broken, I just mean that the seed value stored in
bip_iter.bi_sector is strange in that it's initialized in units of
512-byte sectors but incremented in units of integrity intervals. As
you point out, the remapping step makes the initial seed value
irrelevant, but I was certainly confused by it when I printed it
during some debugging. I can update the commit message to clarify the
rationale for the change.

>
> For writes, the meaning of the bip seed is: "This is the value you
> should expect in the ref tag for the first integrity interval in the PI
> buffer I prepared". With block layer autoprotect, the seed is set before
> generating the PI and thus implicitly affects the generation.
>
> When the write operation subsequently reaches the bottom of the stack,
> we will check that the first ref tag in the PI buffer matches the
> supplied seed value. And then proceed to remap the ref tags for each
> protection interval to the target LBA + n since that is what the storage
> requires (ignoring the odd Type 2 interval mismatch for now).
>
> For reads, the meaning of the bip seed is: "This is what I expect to
> receive in the ref tag for the first integrity interval in the PI
> buffer". At the bottom of the stack we will receive PI from the storage
> and that will contain ref tags matching the lower 32 bits of the LBA
> since that is what the hardware returns. And we will then remap all
> those ref tags starting with whichever bip seed value was requested by
> the caller. It doesn't matter whether the requested seed value was 0,
> 10, or 42. The ref tags are remapped to whatever the caller wants them
> to be.
>
> I tend to think of the seed as a register you program with the value you
> want. And then hardware or software remaps between what the storage
> device's protection envelope requires and what the application (or in
> this case the block layer) requested. With SCSI + DIX 1.1, the seed
> literally controls a remapping register in the HBA ASIC. In NVMe we have
> ILBRT/EILBRT.

What I find confusing is that the seed value stored in
bip_iter.bi_sector isn't what's actually passed to the SCSI/NVMe
device. It's only used in blk_integrity_iterate() and
__blk_reftag_remap() to generate/verify/remap the reftags in the
integrity/PI buffer. However, (E)ILBRT field (taking NVMe as an
example) comes from the physical block device offset rather than the
reftag seed. See t10_pi_ref_tag(), which returns blk_rq_pos()
converted to integrity intervals. It looks like this works because the
remap step ensures the reftags passed in the integrity buffer match
the physical integrity interval numbers, but this means the device is
comparing physical integrity interval numbers rather than reftag
seeds. My point is that if the remap step undoes the effect of the
seed by setting all the reftags in the integrity buffer to their
physical integrity interval, I don't see why the block integrity code
bothers setting a seed in the first place.

But it sounds like this may be a longer discussion, so I will split
out the two fixes for 7.1 into a separate series.

Thanks,
Caleb

