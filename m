Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20620C5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZsigVlxc1Yx5xrsa1S52pC/wAn87RkEo7OEJR846FGI=; b=SCUbAvOSXHE2D1tZbZdRZY91ob
	R3XmUBqCAbSEW5/AnawzbLFdqBGkYr3xBT2Fbo20R39EnMMe49rZXZtsnuQdPnMtBQdpryRaBndVS
	ivRQtHnZB/VeEDHu2GbuTUA/4IP2kWEzb8eZb6tNOLosd5D5xTvDF5AXV+CeTaMh/JM/dikjFAraN
	+A4Yu9SsWRRApm0FC+9/JdrAV1Wxfaa2AuracUKClTBAQC06xiHFzh/KOo8q1kM5jj0HCJtIEBg9d
	AWvD98R4Jkjevv3t36HxiOTkQ9HoSkMmDFCDuUE1UCtgrLQhmLZaEfh00kjybRJnVn4iAOaiIiMHL
	v052giDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwNfg-00000008RTM-3wH9;
	Tue, 18 Aug 2026 17:32:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwNfe-00000008RSx-0szg
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 17:32:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787074335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsigVlxc1Yx5xrsa1S52pC/wAn87RkEo7OEJR846FGI=;
	b=adXZ+QHk33K0VBJk41VEzSagDUMHBwoNy+LRv8Cj+O1uwiEvrg5Rkv8gut3kkyLK2S871o
	v9mwG4gTCqJxDjS9YN5iRqGbp3OfSgjqb8T9y+030TRW1BGyTcZTijg5ZHWrl3KaeJ+x6U
	yVos3zuc/hPgNipvbIl04nTZg7GhtVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Vk-8hWHsO6qKZAjiypooVQ-1; Tue,
 18 Aug 2026 13:32:12 -0400
X-MC-Unique: Vk-8hWHsO6qKZAjiypooVQ-1
X-Mimecast-MFC-AGG-ID: Vk-8hWHsO6qKZAjiypooVQ_1787074331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C7BE1800869;
	Tue, 18 Aug 2026 17:32:10 +0000 (UTC)
Received: from [10.17.17.225] (unknown [10.17.17.225])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AF383000239;
	Tue, 18 Aug 2026 17:32:09 +0000 (UTC)
Message-ID: <3e9c2a03-9a8f-4e20-9c7d-1b55edc58a9d@redhat.com>
Date: Tue, 18 Aug 2026 13:32:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
 <aoK5sfNpxIUz7C02@shinhome>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <aoK5sfNpxIUz7C02@shinhome>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: bZnaU6Iy4htYQ5lDkCiLXOduesZVQb7mVPqcBn5H66o_1787074331
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_103218_331659_91580124 
X-CRM114-Status: GOOD (  11.31  )
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

On 8/17/26 03:38, Shin'ichiro Kawasaki wrote:
> Yes, it happnes always I run the test case. After I rebased to v7.2 kernel, it
> shows a bit different message:
> 
> nvme/070 (tr=fc) (test nvme-fc marginal path handling)       [failed]
>      runtime  37.200s  ...  38.926s
>      --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad       2026-08-17 16:34:17.997000000 +0900
>      @@ -3,10 +3,14 @@
>       Testing iopolicy: numa
>       Changing FC links to online
>       Set all online: pass
>      -One host marginal: pass
>      +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is being used, expected no use.
>      +One host marginal: fail
>       All marginal: pass
>      ...
>      (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)


I'm seeing this same issue on my QEMU based test bed.  This is a timing problem and the issue does not appear on a high CPU count system.

Jesse and I will work on a fix and update the patch series.

/John


