Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7982C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:46:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A8B20738
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvPkEmqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A8B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sLjplpZm/YeihvBGEdkMYsRY0Kb0yFBwmQmyYJYZvmg=; b=BvPkEmqRNQk5VDpv2hZ20Fcrf
	rP0uLaWx2fJmeJsBPqq6VjygV/taqDbwOl0u26/W1DhEju4QqzLRQKLCEIJ5lWpMAXDG1tifnpLtD
	rf1R9M5Xno6vlJwbZ0xGECuqdh2Jpubs9iEsheezDQPGryGT1D3QmT4wkQ+7e+znT+Ao2N92OloZV
	h0wMui8wPPDNGFgwtwe/zzCGccQ9aq3CNilFcqFm1KdSP95wu9g4cVkM9EdIzD2wpv1ePruvkYK7d
	XWJ3MXohkrvrej6Zae72EHlPzNogGsQFqgxffG92eBqu7tLkGizhwmiJJw0rVaOMYgKJTwoI1rg1v
	BoHjy7tbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo9TN-0008L9-VT; Wed, 24 Jun 2020 17:46:09 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo9TM-0008Jz-BE
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 17:46:09 +0000
Received: by mail-pf1-f193.google.com with SMTP id f9so1486231pfn.0
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 10:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6ZuPfoIsOlhMNdcAnzkgxdvTGnwTXlBb8uOi41AOKTw=;
 b=YPi0jz8Ub/2Ii3A+v+qu76235YJNXiv34xB7jIfd64Xnj2CH/LFVRaF6XAhQdtgJrj
 MocsdZFTi3LiTOucdGQQlCdaG6ruRdtSKYgIEyfYtOB+sfWsiUUFzIYUnGgpFN28DFHN
 UfrAyBsyQ7kj77brr7fT+hhlw/3+ffex5dK/UaKJwRTMrID/zSgH9ZOu8q0V0UUXrp3N
 DuH7ZUgTESZherfmawKbMML9Uwn6yednYeUnGQ/lRluBKAwlbg8jMnJ6NywL73Wtdskr
 2l11QUnMA1tJGqnVga7bFazm1YNrqY8IWqYoWn8dHcNTTLURFvrVM92IsSnYJAOJ60ce
 WfJA==
X-Gm-Message-State: AOAM530cnpg+5jno9YSLODVysZb08G/fSEn3CixlO1+FdZVluHl0Lmkm
 DEVWOelUWmCpus3Cr3QwwFc=
X-Google-Smtp-Source: ABdhPJyCpH43JPzB8LeKOtaZuuTnplK2rIVDji8XDVbr6qO/Rz027O/8l0VcqoMtWpgzjHppDj1oUw==
X-Received: by 2002:a63:d208:: with SMTP id a8mr22435313pgg.351.1593020767184; 
 Wed, 24 Jun 2020 10:46:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id o1sm22040841pfu.70.2020.06.24.10.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 10:46:06 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
Date: Wed, 24 Jun 2020 10:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/24/20 10:25 AM, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
>>
>>>>>> -		len = nvme_process_ns_desc(ctrl, ids, cur);
>>>>>> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>>>>>>     		if (len < 0)
>>>>>>     			goto free_data;
>>>>>>     		len += sizeof(*cur);
>>>>>>     	}
>>>>>>     free_data:
>>>>>> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>>>
>>>>> We will clear the status if we detect a path error, that is to
>>>>> avoid needlessly removing the ns for path failures, so you should
>>>>> check at the goto site.
>>>>
>>>> The problem is that this check has to be done after checking all the ns descs,
>>>> so this check to be done as the final thing, at least after processing all the
>>>> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
>>>> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
>>>> end without error.
>>>>
>>>> Even if the nvme command failed and the status was cleared:
>>>>
>>>>                   if (status > 0 && !(status & NVME_SC_DNR))
>>>>                           status = 0;
>>>
>>> This check is so weird. What has DNR got to do with whether or not we
>>> want to continue with this namespace? The commit that adds this says
>>> it's to check for a host failed IO, but a controller can just as validly
>>> set DNR in its error status, in which case we'd still want clear the
>>> status.
>>
>> The reason is that if this error is not a DNR error, it means that we
>> should retry and succeed, we don't want to remove the namespace.
> 
> And what if it is a DNR error? For example, the controller simply
> doesn't support this CNS value. While the controller should support it,
> we definitely don't need it for NVM command set namespaces.

Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
that the controller replied an error and its final, so then you can have
extra checks.

I think the point here is that if we got a non-dnr status, we should not
take any actions on this namespace because we need to retry first
(either because the controller is unavailable or it needs the host to
retry for another reason).

>> The problem that this solves is the fact that we have various error
>> recovery conditions (interconnect issues, failures, resets) and the
>> async works are designed to continue to run, issue I/O and fail. The
>> scan work, will revalidate namespaces and remove them if it fails to
>> do so, which is inherently wrong if these are simply inaccessible by
>> the host at this time.
> 
> Relying on a specific bit in the status code seems a bit indirect for
> this kind of condition.

I actually think this approach covers exactly what we are trying to
achieve. But I'll let others comment on this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
