Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55144E83043
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 03:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhbcDfd6GKLuKNUd6g7wVJ0vSapI862aCf53bUJiWfY=; b=kWbMwiEICCDmxSTYaQ0XzizfrX
	l8N84kkvLoZ3lwwExb5bbI4SRkmfRO0N96Fb8EqWAr+r6dxTp9ucx1iMjB/Gp+PuZgPrd0RRm/y+l
	9pxx2Dh3zK6ZiqyXMrsQiPQfAj/ovyKot6hdAiJsrwJ0DbTncWMf+WDN+A6UnXhhfVTE6CqHGAHHf
	XaiNhDLGJJ2PIz09Iclbdm4bSw+jATibDbcAsCAiLUFlGtDRd2V5wM6XDSapRrrKoXPj6vGFPbQqB
	3Pw6e7YnmBTeqJrOJzIyQVUXhxXnoDCzL7It8hhKTv8R32Uil9eF/nC5C6gt8JMfIBVqbO1ks0KTs
	UA5pbxEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6s2-00000005z7v-2JOD;
	Tue, 03 Feb 2026 03:14:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6s0-00000005z6g-2PlR
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 03:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770088466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhbcDfd6GKLuKNUd6g7wVJ0vSapI862aCf53bUJiWfY=;
	b=U4Gr88Atsf8WFxt31hvO48ZfsSpEDIgy5/6ETkYoB2kPvTqrWZjgi1Dcq53tlKtjH0xAms
	SC54z7F1usxN9xYyr66X0UGAWLZreSxgo2wXtjG0TICmB/ZWn3a2PHEFJmetytYlKhgR79
	JUgGRZWutOv4PNe25u7MH9f6Vj0LJNc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-ZsMK_n_wM4-_HK4DbdKufw-1; Mon,
 02 Feb 2026 22:14:24 -0500
X-MC-Unique: ZsMK_n_wM4-_HK4DbdKufw-1
X-Mimecast-MFC-AGG-ID: ZsMK_n_wM4-_HK4DbdKufw_1770088463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10047195608F;
	Tue,  3 Feb 2026 03:14:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 362251800285;
	Tue,  3 Feb 2026 03:14:18 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:14:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
Message-ID: <aYFoBafih46bLK0T@fedora>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_191428_684211_E88CA9FC 
X-CRM114-Status: GOOD (  13.88  )
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

Hi Hannes,

On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> We are currently working on implementing cross-controller resets for
> NVMe, which requires to send a command to the target which then should
> terminate all commands on a given controller.

Can you provide a little background why this reset is required? And for
solve which problem?

> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
> Which then recurses into my all-time favourite topic on how to
> abort outstanding commands from the fs/bio layer.

nvme_quiesce_io_queues() & nvme_cancel_tagset() may do it, or do you have
other new requirement not covered by the two helpers?


Thanks, 
Ming


