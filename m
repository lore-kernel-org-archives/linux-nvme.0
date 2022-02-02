Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1231BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JlQUO8+UiXbI9p5AkFOPqUJ49XgowWktQfXDPY0CVBY=; b=nklTsi9i5YXF/I6yHCpwR1Nlrs
	CcuwwIQQo8+u0Uahae1OCqy5MtNQ8rLTWCBZghg3ilGrA+DV9XV6LnuifmY7I+4hFeq5NxExx01Xx
	Cd53hfTjXAnyb+8K84IzMGryVQNgImapgLQf72fB2aSm/ETSEPW+veCHrn3aebO9CB3sgOGufxHby
	zWzg7nV/vpwvsOK7NWMIk4dLMeiTXqg7SqY2InyNs+zMAi+sREZjwsLwrrHgy2YlZZtuZAsCwLAzh
	okgbCnZa4ocC1RP1vr5YJCWaMlQGv2EgWk4DLJxXnaNQgJE1KlDHvkMKWC2qNEifgwthQsPQtZK0g
	mRiihN3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFFS7-00FJ9D-7Z; Wed, 02 Feb 2022 13:13:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFFS4-00FJ7l-1b
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 13:13:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A08521F3AC;
 Wed,  2 Feb 2022 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643807614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlQUO8+UiXbI9p5AkFOPqUJ49XgowWktQfXDPY0CVBY=;
 b=qAQmbDDNlbwdOrfXmkONjHnYlZJSTA33fOEY83xMPUwZBTwaQ1zkGN3UZx06Ykf8J2tgVe
 6e4XSNmE+0+cVP2VTClabEBNLR152C1fuOoRB8ygLxtZllzO/Vnwc/m49JsY93kTO0MAmn
 qqTRBfsW0i5LflljRtikurUrcDhsbzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643807614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlQUO8+UiXbI9p5AkFOPqUJ49XgowWktQfXDPY0CVBY=;
 b=n+Xp2eOz4tUnUDhlfz56j0sVtYs+NL0aDL5lkCjN8ewDL9FXPiRiOzgdg+6vh5grW2X4cE
 Qoo008H2iWe2m3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA6813E48;
 Wed,  2 Feb 2022 13:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U+IUIX6D+mHbPwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:13:34 +0000
Message-ID: <6acd13c3-5e98-b050-bcc4-9d075e013817@suse.de>
Date: Wed, 2 Feb 2022 14:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 3/7] lib: add rocksoft model crc64
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Eric Biggers <ebiggers@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-4-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-4-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_051336_259531_DA16F8D5 
X-CRM114-Status: GOOD (  10.95  )
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

On 2/1/22 20:01, Keith Busch wrote:
> The NVM Express specification extended data integrity fields to 64 bits
> using the Rocksoft^TM parameters. Add the poly to the crc64 table
> generation, and provide a library routine implementing the algorithm.
> 
> The Rocksoft 64-bit CRC model parameters are as follows:
>      Poly: 0xAD93D23594C93659
>      Initial value: 0xFFFFFFFFFFFFFFFF
>      Reflected Input: True
>      Reflected Output: True
>      Xor Final: 0xFFFFFFFFFFFFFFFF
> 
> Since this model used reflected bits, the implementation generates the
> reflected table so the result is ordered consistently.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

