Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BBCEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OkkvN5LaeJ7jSZxGFsHd4Qul6dNlN5wnF04FypSAqNk=; b=nV8q8QIWjBmWB3k4Cx95FqGphW
	oIdE12Zi0hUSiUTDIz9JdhkLvfsSHUV6NGIyr0qNeJ0pB0w9g3vLHEzJIIhx+XaJ4/eZtjfoj55J0
	f3+qFj+kQIgHZVWNQb34lPUIKaLwMzegSVyuMbOFBgh1ZgknYue8k6FHmRFMDOS5++lc4wg0s0ND2
	BP0wc8rW7to5KfiOcnRR3hszVBTWxE+b7CxWbIKBT0v5c5WQKpipXe7NzmI0M1ONsf3vnob9cp8NC
	COLBSnuGAo57DmhIK4BUFY008tE+tKgbswxZKcxzZsiSk3xwe87VjhVMuQlOuNtLTMysrTas3f0fq
	/bUhorog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVMw7-00Fz6m-27;
	Mon, 14 Aug 2023 02:04:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVMw4-00Fz6L-2k
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 02:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691978636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkkvN5LaeJ7jSZxGFsHd4Qul6dNlN5wnF04FypSAqNk=;
	b=c+4/oHVFm/xnS3MXnP5HpjDuLGrLnd1upw0XmoN296Ha2MJlCPHI4dX/v+Vyk4p2SGWhyo
	02P1cKaABdJg3ZAcL3F3Pg60snWGoONEyhqzu4lWbPBzawPA+voNnN0kPaUOH1KiYIBxJg
	u8nmg2JI7gobL/WE0HW38ITovRkqmO8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-BNu-ZOwjOI-42Xcp2PFdzA-1; Sun, 13 Aug 2023 22:03:54 -0400
X-MC-Unique: BNu-ZOwjOI-42Xcp2PFdzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89513C02532;
	Mon, 14 Aug 2023 02:03:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B33400DE97;
	Mon, 14 Aug 2023 02:03:48 +0000 (UTC)
Date: Mon, 14 Aug 2023 10:03:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Guangwu Zhang <guazhang@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	ming.lei@redhat.com
Subject: Re: [PATCH] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Message-ID: <ZNmLgBW06NZWUMo1@fedora>
References: <20230810021640.252033-1-ming.lei@redhat.com>
 <CAGS2=Ypt3U6AiR77B-WDUMB5atGt9YsuQoEn+PgZVmcH0n8tXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=Ypt3U6AiR77B-WDUMB5atGt9YsuQoEn+PgZVmcH0n8tXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_190400_999408_49F55035 
X-CRM114-Status: GOOD (  10.78  )
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

Hello Thomas and Guys,

On Fri, Aug 11, 2023 at 06:59:25PM +0800, Guangwu Zhang wrote:
> Hi Ming,
> I don't find any IO block after apply the patch.
> 
> Tested-by: Guangwu Zhang <guazhang@redhat.com>

Can you take a look at this fix? And this one solves a couple
of nvme io hang report in case of cpu hotplug & reset involved.

Thanks,
Ming


