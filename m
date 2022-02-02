Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bcp04e1xn7q0Nbal9eCkQGo3QVCsVp3wNyotn26SUZc=; b=1vcrLA4teJKScHpYmNN5VSIGVb
	Joio5d69CMI4pjFhfAUPPfbANp1qQ/TJiGb4/w31mj0/R+e0Y414WgVMXFwpLm/2Q1L/2oVG5VJLK
	WGE0c2yoLFMhXk3KSTAvM+nMRY82InHpUgs7D9+E3h/8+xfFLdE65b/63bWyn4hP29z3J9r+vc6nW
	8VMSo9ZAFA1xGFJj4y3s3evWwaqxO+bZz7ostyNH67zXVapj3Xd6J30nAkoeBY/VZI86KOIUiNpNF
	aXu8bFdEhYcfz3Q6Z50L5ByWyJAAtGjahPL0VNrwIUZ67/L0HPMcMmI1TjM4EgZjJFJhhXq/l2plj
	muaan3+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFFSt-00FJLD-06; Wed, 02 Feb 2022 13:14:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFFSq-00FJJg-0t
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 13:14:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE3032113D;
 Wed,  2 Feb 2022 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643807662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcp04e1xn7q0Nbal9eCkQGo3QVCsVp3wNyotn26SUZc=;
 b=LZs0ZRhvdcYR4fHgsCej3MaQSN3G4oIpS/kCbCgOmUTVhOlkBQQhuDRxMjPwUMsMrI3SaT
 E6g7iLhxHav8I7ggM5n+2vqmangAHogtTcA2Orv4zkgue4a4HwosZZrYNwbvylYiromKcf
 p0+RbuqnABB705j7wYl/55XGBj4RebE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643807662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcp04e1xn7q0Nbal9eCkQGo3QVCsVp3wNyotn26SUZc=;
 b=r9xPJKaqrE/bIIJMhdvUrixtqOxNNTZ1cWRhDYeQhs7tG4PzA68uodopZ7ROBkL6z5kp+c
 S2gBwkyJ2d9Ct6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E5313E48;
 Wed,  2 Feb 2022 13:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id InP9Kq6D+mFFQAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:14:22 +0000
Message-ID: <b46c5a9a-670a-2989-2429-f28b2bafdfc2@suse.de>
Date: Wed, 2 Feb 2022 14:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 4/7] lib: add crc64 tests
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-5-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-5-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_051424_239988_82E97DDF 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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
> Provide a module to test the rocksoft crc64 calculations with well known
> inputs and exepected values.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Fixed Kconfig dependency
> 
>   lib/Kconfig.debug |  4 +++
>   lib/Makefile      |  1 +
>   lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 73 insertions(+)
>   create mode 100644 lib/test_crc64.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

