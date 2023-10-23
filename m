Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5D5C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qyq3w+n1TechCfBG3I8TTLhuGd+901wxGesJfF4JBoQ=; b=GNIoKfyXdFVGD3oFVPv5TDTu1s
	qqP10NMPxsT456LPR7qP0CpX686LNon+5GPEDTkoimRzeL7IdCMA5aTWt1AMIhjVcFU5u/8O+S7Rb
	m0Y0caaSP8RZhpcvg+jHPJuYRT1A35GYXFu5nOL9uv+oYNPPsWh+5oHWNm8r21Z2QvLDu7Q/2truu
	BTtLYHXjPw/BZXYCkSeYiJ2H8EoZny7RyRuN2m3hqA7RYS85LAwRn62vD9D60e9nInqpSP0wFJTCq
	uviENyoN0MJXe1bkgLzBiiflzT6gisZqHGlo41G1IEsvPka0bUd4d27G+Lkdj4idmMJ9zua3QJ6EP
	ymooRY6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qure4-006wFm-1g;
	Mon, 23 Oct 2023 09:54:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qurdw-006w9H-0p
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 09:54:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8861FE0D;
	Mon, 23 Oct 2023 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698054877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qyq3w+n1TechCfBG3I8TTLhuGd+901wxGesJfF4JBoQ=;
	b=XdID1lvHUhe6or+HoxMSz9vj5nMwa7HaRHFG5j2LHE11DV0pZxIaIDX2RBuLdAgdGXyuu7
	foD6cD2yb8pTvG5qzd1selmjjIwn1YBn+DnlwiBOPMFcnq4k4F6qqymGUD8ySJG+KcMP3J
	e2P9E1jRAyJiolrpuY9DZurThJUHb8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698054877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qyq3w+n1TechCfBG3I8TTLhuGd+901wxGesJfF4JBoQ=;
	b=B4ICVQet8BSkMm6jmolu5lIeIVP3BxNB6FesyMJM8aRpcLs975kCxNSwl0EeLlsR+56QoT
	+ciq/KgBKhTKovCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F040139C2;
	Mon, 23 Oct 2023 09:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ls9yIt1CNmVUTgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 23 Oct 2023 09:54:37 +0000
Message-ID: <94326b59-60c1-4d0b-863b-cec0f9bfe1ac@suse.de>
Date: Mon, 23 Oct 2023 11:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231020142600.47246-1-hare@suse.de>
 <ZTKdFHTw3949UKTv@kbusch-mbp>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZTKdFHTw3949UKTv@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-0.15)[68.94%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_025440_450468_DF58535B 
X-CRM114-Status: GOOD (  19.97  )
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

On 10/20/23 17:30, Keith Busch wrote:
> On Fri, Oct 20, 2023 at 04:25:56PM +0200, Hannes Reinecke wrote:
>> Hi all,
>>
>> Setting up I/O queues might take quite some time on larger and/or
>> busy setups, so KATO might expire on the admin queue before all
>> I/O queues can be setup.
>> This patchset fixes this issue by moving the calls to starting
>> and stopping KATO into the quiesce/unquiesce functions.
>> That requires some refactoring/alignment with some transport
>> drivers which do not always quiesce and unquiesce the admin
>> queue.
>>
>> As usual, comments and reviews are welcome.
> 
> The pci transport doesn't care about keep-alive, so I don't think we
> should force everyone to have to consider it.
> 
> Wouldn't you want to start the keep-alive on the connecting state
> transition? Something like this:
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f87aafa2..a44b1206b20ad 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -583,6 +583,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>          } else if (ctrl->state == NVME_CTRL_CONNECTING &&
>                  old_state == NVME_CTRL_RESETTING) {
>                  nvme_start_failfast_work(ctrl);
> +               if (ctrl->ops->flags & NVME_F_FABRICS) {
> +                       nvme_start_keep_alive(ctrl);
>          }
>          return changed;
>   }
> --
> 
But we start keep alive unconditionally nowadays; each and every
host driver (including PCI) is calling into nvme_start_ctrl(),
which calls nvme_start_keep_alive() without any checks.

Be it as it may, tying it into the state transition won't work
as the 'CONNECTING' state is entered _before_ any queues are setup,
so starting keep-alive here would be too early.

Cheers,

Hannes


