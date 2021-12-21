Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B29C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mq++G91SwNol3Or9Dye7ewqOdul4SlCdTC3udhm1AUo=; b=hnPlmnVyjFxjRPdaiofRUyBKmy
	a/Krqs7dfyXI1zyAiA5ZzPQgsB5jrXkn/OOSBLNnDVAEyClp/GdaXDa+1qbZTNjHN/XelQrHYPePK
	jBqqdz8cXHzDmmf0Y6JUZ+bm2hRFSNZyPYETca6eyH6UaAURVcGPuOWd7TqYwFsumYif+BnlnafWP
	p9xatlClv6Jnm9tRHKwYvNt5zFLNZTWoEetKf5mGOIQtWOjuoTsO83t0oGQPjMs5eBXti7HwofOeS
	VOA8a4XRlR54RVBpSghdXAZdMP7rjJ8+eJpQpxe51hCw5SkzaXy1AyXOVhcMeFxTNl0+roIiSz0+C
	aJTbWhcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzenE-006qRg-Jo; Tue, 21 Dec 2021 13:03:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzemz-006qQ8-6o
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 13:02:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8656A210F7;
 Tue, 21 Dec 2021 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640091763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq++G91SwNol3Or9Dye7ewqOdul4SlCdTC3udhm1AUo=;
 b=bBDXHhJSVzBavIMFdng7aIHbyfJHeRIn6GqVm1nZmDjUe4Rd6dcCp00w+Bbteeh/q4HatB
 O/0EBaNPAoB8QlvIwV+U16UdurwnX0y13FnJ1NlBx0ZexxlP77wOi7fjaHhcQw0PZ9J4IZ
 23lNlCH5ZTrmDW1ptilfnmKNV1kYkhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640091763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq++G91SwNol3Or9Dye7ewqOdul4SlCdTC3udhm1AUo=;
 b=LCdvCdcgtQMLw+ItSokswHJUTcYWQkRRhMJKMU59L3kporxpgm6RKJuwVBGS20qTdVV7Mg
 DuOXfXejNkI0RUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 791CE13C3D;
 Tue, 21 Dec 2021 13:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Bx6OHXPQwWHVJgAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 21 Dec 2021 13:02:43 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] nvme-cli: Make connect-all matching be case insensitive
Date: Tue, 21 Dec 2021 14:02:40 +0100
Message-Id: <164009175251.30030.7452352641833716630.b4-ty@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217222022.30516-1-jsmart2021@gmail.com>
References: <20211217222022.30516-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_050245_417154_3895E5BF 
X-CRM114-Status: UNSURE (   7.86  )
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

On Fri, 17 Dec 2021 14:20:22 -0800, James Smart wrote:
> The comparison routine that checks discovery controller traddr with a
> discovery log traddr uses a simple strncmp.  For FC, which kicks off
> connect-all requests vay systemd, the nvme-fc transport will build
> traddr strings with lower case hexadecimal.  Some FC discovery
> controllers return traddr strings with upper case hexadecimal. There
> was is no rqmt in the NVME-FC spec that it be upper or lower case.
> Given the case difference, the connect-all fails the match logic and
> doesn't connect to storage.
> 
> [...]

Applied, thanks!

[1/1] nvme-cli: Make connect-all matching be case insensitive
      commit: 1264c6323937c4a0342174fdd9be5a66ab1eaf24

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

