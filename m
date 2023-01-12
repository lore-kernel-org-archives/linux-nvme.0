Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A097C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wg9Mv9LEG84Sl8ZLUqj76az2pBXif7s+JUxIL5PzMwY=; b=Dw+4x9kvD7IjcBoOvDIhAA45yh
	yJmQXfW4ccyvtYqIsGM9QQyUa7kXSahxcEeH3lpqAxL1hJOz5PaPVE/qr7H615XY8NvTM08YPcmg0
	i1cQrW6o1pkwZIERmMZ03KJquxWBGEqd8/z7LYIlJXLLFKyylwxIHavGt/DHhFcT6TKySzK+oNyln
	EZc3J6ElpSkBwCdW6qvma5uTBqCFnlUvF0/aKI3pGmGdvlbPFVGH2vc3uMqZtJiswiAn4uV/ygyz+
	ljLB60Zhy9700y8qw6E3i5xRALI1AExKW20r2PhELIH7ZRObz9XPVTnsiCEg40DKuCq8orFcXhFVv
	BrQsPJkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFuz5-00EcYj-QS; Thu, 12 Jan 2023 10:38:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFuz2-00EcWM-4R
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 10:38:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 757513FC25;
	Thu, 12 Jan 2023 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673519931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg9Mv9LEG84Sl8ZLUqj76az2pBXif7s+JUxIL5PzMwY=;
	b=XOnaS/w3l7GE8CiSyH3MrOMAXLVNQ5gVaeSX55dI8DSMr4kr3RYDV3VB3XWX65+oV1DRL7
	A20pq6Pdh/zyhprc/ONRy3zYUgvF1pM/AXIyOncA4qkleTDFsshwfBCD3lm0TWMN7VnL7E
	DfG5dgWQ69Qopbx0PYQ4IZBkJcLcpEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673519931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg9Mv9LEG84Sl8ZLUqj76az2pBXif7s+JUxIL5PzMwY=;
	b=zNm32Gk/efl50XAZ1kXzTQyqvW8LVTWeO5ntz9SmpZrNu3TnSl+68LeUbGIc1NX/eZVl71
	AlfDfobXo0EJToCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B40913776;
	Thu, 12 Jan 2023 10:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hq3WFTvjv2MSKgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Jan 2023 10:38:51 +0000
Message-ID: <dde84087-7cdb-7d08-e3c2-f19d02574b9b@suse.de>
Date: Thu, 12 Jan 2023 11:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: nvme-fabrics: devices are uninterruptable
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagner@suse.de>, "smith, erik" <Erik.Smith@dell.com>,
 "Ghalam, Joe" <Joe.Ghalam@dell.com>, "Hayes, Stuart"
 <Stuart.Hayes@dell.com>, "White, Joseph L" <Joseph.L.White@dell.com>,
 "Glimcher, Boris" <Boris.Glimcher@dell.com>, axboe@kernel.dk
References: <CGME20230111144340epcas5p3940d3fbf8bd19771bf1fb55ba56ecf95@epcas5p3.samsung.com>
 <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
 <20230112053655.GA743@green5>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230112053655.GA743@green5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_023857_041172_B0971373 
X-CRM114-Status: GOOD (  19.69  )
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

On 1/12/23 06:36, Kanchan Joshi wrote:
> On Wed, Jan 11, 2023 at 02:37:58PM +0000, Belanger, Martin wrote:
>> POSIX.1 specifies that certain functions such as read() or write() can 
>> act as cancellation points.
>>
>> Ref: 
>> https://pubs.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_09.html#tag_02_09_05_02
> 
> Not exactly related to the original question, but I hear the
> cancellation requirement for passthrough too.
> 
> And it seems feasible as io_uring provides cancellation interface
> (IORING_OP_ASYNC_CANCEL) to user-space.
> It is only at io_uring level, and does not percolate down to lower
> layers (as we don't have an interface).
> Will it make sense to grow such interface for uring_cmd. Either
> a new file-op ->uring_cmd_cancel or existing ->uring_cmd with new
> cancel-flag. Not sure if ublk too needs it, but NVMe can support this 
> (new op/flag)
> cancellation by issuing abort-command to the device.
> 
> Down in nvme, we would need command-id/queue-id to issue abort command,
> and that maybe tricky to store (although it is something we do for
> iopoll). Maybe I can figure something out while cooking up a RFC.
> 
> But first things first, Christoph, Jens: does this sound reasonable?
> 
Command aborts for io_uring! Yay!

Something I have been needing for since ages immemorial; KVM suffers 
from this as we can't do a command abort from the guest.
Meaning we always will have to wait for command completion _from the 
host_, making it impossible to trigger a failover or even start error 
recovery.

So, yes, please. We should at least look at it, and io_uring looks 
ideally suited.

Cheers,

Hannes


