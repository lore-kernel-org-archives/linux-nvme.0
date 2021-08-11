Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308FC432BE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD9B60D07
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FD9B60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fGoBlG/rFaFlGj4ZL02Yh1CDeT8NJr9LfTbdBm4o8OU=; b=dOJvJb2AlLxAuJ
	Cq2h49Ct+h4WWKbI6J1ytvjUdxxIUHy1pX9YeIQPy2rBQOrvlL63GrEug4ywfARWQH9ElR7Oisp5T
	Jlmm+dRg5xQtoj27n3DSx/pAQeZc0rKzCNh0hSZLj23n1V4voTBafaw8sekgA7MuQqHp3FNFOL8lN
	zwHMnrUjbXnK28Jb4ZF1tIN6bdFsMF8hAoaBmh8lxaHZeVy5BG8oc4jeCMYvlMuMDkdPh5JEQco+l
	PgUpO1iyOwrWtYOxPkG9wzN5bbuNWbloCiD599EjlVeKsfTfG/pvgjMklj2ecI+/M0YmL6yylQ45X
	rajKyDkLIdNV80n5EkAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDlVJ-006dCa-7I; Wed, 11 Aug 2021 10:30:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDlV7-006dAk-J9
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 10:30:25 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 350E9221D1;
 Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628677820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9PROUPtd8tEVskY/x6F4cQKQn0LeaTzerYxm4i+slnw=;
 b=zTIZyeUy8mE4QaOiuEp13YJvKZp5L8XAaUDYhhMYAHx6k1kyQ4hvY18ZvQ6TrWZMh+jdyH
 L3GXpO4H/jgTt9l4jZG7qpY62madXczy2FiLtK2etIFlnP+t0Sp9w4FdslWFNiWLFPrX86
 RDj5gM59hmtd/daztRelmR7gfPICYaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628677820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9PROUPtd8tEVskY/x6F4cQKQn0LeaTzerYxm4i+slnw=;
 b=2YGzMIs6bMSGM1nNVEVwRaSd49v37+r29fwBw8DUzlbZE3C1SFuGEIYZYTIoAiW0IoLOQn
 njjPEo2fxahy3xAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1D66E131F5;
 Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id SkrXBrymE2G0DwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:30:20 +0000
Date: Wed, 11 Aug 2021 12:30:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210811103019.j2smukkfseqa3qdr@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <20210804080847.bajae2twtnmccvq7@beryllium.lan>
 <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210811_033021_840035_23F8749B 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 10, 2021 at 06:05:04PM -0700, Sagi Grimberg wrote:
> Why is there a conditional freeze?

The freeze only happens if I/O queues have been created/started. If I
understand this correctly, this is the corner case we were only able to
establish the admin queue and fail later to setup the I/O queues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
