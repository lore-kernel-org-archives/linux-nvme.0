Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B8C64EC4
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Mar 2023 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7He52ReEytUkOdvOKqQmnTf8GaP3jqrOFVivPTUpXBg=; b=j7A5yzsJlOJ8uJSxl4W2Xx0StK
	Z5BIWV+UTwkTC5mziTynCHTwaVa0k6XMsi61x8+i4XqstotfNPwi1xJ+gcZP67tuNyl6jkpHPajWB
	H0EX/z00+T7PS0z7JVE7CUjqLL5HgKfmCwCSVs0YfTjdBE5ZhUqf2Q7JysrKjh0nJNmPzod5UezBm
	SCIbq90zS+ZJmIMyDUfzgnQX22SyytGfBVf1Ks/uX9CBbhHdNf4B5aSmlEfpiMc+QaiwnlS7Pgox0
	337KL7ITDu5+DirhThDmx8eIf+u1/XUv5VZtWtpdLGIZjR84foITwD8Cl2RbbSAUgK8O6lOu+ux/j
	kiBY7Yig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYPqV-008qFr-OE; Sat, 04 Mar 2023 11:14:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYPqS-008qEt-TT
	for linux-nvme@lists.infradead.org; Sat, 04 Mar 2023 11:14:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC4AF21EF1;
	Sat,  4 Mar 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677928471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7He52ReEytUkOdvOKqQmnTf8GaP3jqrOFVivPTUpXBg=;
	b=Rpmp+gzhXJP4XVFqDPhAqxRYqhaCJoC27sdZUSUJV8ubCXTmBPjcAaDfxB3+sJzATYGaLr
	Tt+W5KGHfRKCOS885OEFsM0lZ4UakX7FscBch/ctyZrqCq+McQXEI5rz/DVAKE/PM8Ll9p
	dWHai7VHsGQHYIPYVCpO9Wk0GaHLflQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677928471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7He52ReEytUkOdvOKqQmnTf8GaP3jqrOFVivPTUpXBg=;
	b=iXAdY+Qic5Bw7mP2RSA9Ho8i1z1OB7Ew68+fGEfR2YHuFZEO7vj2BV+LqWiHEMJ2BC3arm
	a1cqitDMfKDAL3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88D2313912;
	Sat,  4 Mar 2023 11:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4vKXIBcoA2R3TwAAMHmgww
	(envelope-from <hare@suse.de>); Sat, 04 Mar 2023 11:14:31 +0000
Message-ID: <238bd934-1355-8eb8-c897-2f79f9f54c21@suse.de>
Date: Sat, 4 Mar 2023 12:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
 <ZAMb+x/hKPjoFHS5@ovpn-8-18.pek2.redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAMb+x/hKPjoFHS5@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_031433_184215_CF9402B7 
X-CRM114-Status: GOOD (  23.66  )
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

On 3/4/23 11:22, Ming Lei wrote:
> On Sat, Mar 04, 2023 at 09:00:28AM +0100, Hannes Reinecke wrote:
>> On 3/4/23 00:13, Ming Lei wrote:
>>> When investigating one customer report on warning in nvme_setup_discard,
>>> we observed the controller(nvme/tcp) actually exposes
>>> queue_max_discard_segments(req->q) == 1.
>>>
>>> Obviously the current code can't handle this situation, since contiguity
>>> merge like normal RW request is taken.
>>>
>>> Fix the issue by building range from request sector/nr_sectors directly.
>>>
>>> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>>>    1 file changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index c2730b116dc6..d4be525f8100 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>>>    		range = page_address(ns->ctrl->discard_page);
>>>    	}
>>> -	__rq_for_each_bio(bio, req) {
>>> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> -
>>> -		if (n < segments) {
>>> -			range[n].cattr = cpu_to_le32(0);
>>> -			range[n].nlb = cpu_to_le32(nlb);
>>> -			range[n].slba = cpu_to_le64(slba);
>>> +	if (queue_max_discard_segments(req->q) == 1) {
>>> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
>>> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
>>> +
>>> +		range[0].cattr = cpu_to_le32(0);
>>> +		range[0].nlb = cpu_to_le32(nlb);
>>> +		range[0].slba = cpu_to_le64(slba);
>>> +		n = 1;
>>> +	} else { > +		__rq_for_each_bio(bio, req) {
>>> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> +
>>> +			if (n < segments) {
>>> +				range[n].cattr = cpu_to_le32(0);
>>> +				range[n].nlb = cpu_to_le32(nlb);
>>> +				range[n].slba = cpu_to_le64(slba);
>>> +			}
>>> +			n++;
>>>    		}
>>> -		n++;
>>>    	}
>>>    	if (WARN_ON_ONCE(n != segments)) {
>> Now _that_ is odd.
>> Looks like 'req' is not formatted according to the 'max_discard_sectors'
>> setting.
>> But if that's the case, then this 'fix' would fail whenever
>> 'max_discard_sectors' < 'max_hw_sectors', right?
> 
> No, it isn't the case.
> 
>> Shouldn't we rather modify the merge algorithm to check for
>> max_discard_sectors for DISCARD requests, such that we never _have_
>> mis-matched requests and this patch would be pointless?
> 
> But it is related with discard merge.
> 
> If queue_max_discard_segments() is 1, block layer merges discard
> request/bios just like normal RW IO.
> 
> However, if queue_max_discard_segments() is > 1, block layer simply
> 'merges' all bios into one request, no matter if the LBA is adjacent
> or not, and treat each bio as one discard segment, that is called
> multi range discard too.
> 
But wouldn't the number of bios be subject to 
'queue_max_discard_segment', too?
What guarantees we're not overflowing that for multi-segment discard merge?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


