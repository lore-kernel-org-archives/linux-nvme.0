Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FCC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C8420714
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eAKiIMav";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6rnxSCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C8420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p5JahODiyw0ZQ2lmu0fqj2/+1HA20KV2MDdBPGD/Y6k=; b=eAKiIMavjHNToF
	xagcF82Fk7+CNvenwYydbLVl9lOZfG2+Xy3iXyV6NtvL7wyxNBhAxQNE2Nj/9NTMmCAvHfYSKyFWD
	PFWvOEmftfEKdyvsWVlEpfpjsJSWkx8HdVk/yxch7XIml1MeBhWS2kzw/zaIj09GuzBKO4n0Dfj9A
	/F0Vq1/xXrzpwNWB6v834vNvQqDePIzZmN1BQGA8ISvdubBZkLKnA4TbBDrDx+khmKO3i22IXaBln
	XvqTatOCQCZjC+uEWb8H22S1Po1wCWUS26RCfCi/q+aumCxfL4dNdq2C9o2Lqt9x+4ye+F5C3Uh/U
	mHiPjTo59CsCt7scZF4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFRIo-0006De-8l; Fri, 20 Mar 2020 23:43:46 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFRIl-0006DA-2Z
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 23:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584747819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/i7fVFypzH2qrVbDkmIsN4XsFTUFbHNABw3sVctMzw=;
 b=A6rnxSCYvcb4x2Pl4UBKfTjAsur41ZtcYCGZXRRrFV+kFhO5RKAjwna+VuAjuacrcSloXV
 Eao5M5DJmMQ/vqmiIxbkwgTN/I2isrRDn1w9bdZb3Nd/C26oHVYBOPxN23aEGfJDMsGCNo
 SvuFRx5bB4FwnpDJV5jcXrOvOLnBvcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-DajVxBh8NWS3-wxr0nl2Mg-1; Fri, 20 Mar 2020 19:43:36 -0400
X-MC-Unique: DajVxBh8NWS3-wxr0nl2Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB1D88017DF
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 23:43:35 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E54D6EFA3
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 23:43:35 +0000 (UTC)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
Date: Fri, 20 Mar 2020 18:43:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_164343_191758_F162A5FB 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/20/20 5:54 PM, Sagi Grimberg wrote:
> Can you share which line *(nvme_tcp_io_work+0x303) map to?

I'm not running a debug kernel so I don't think I have that available?
Please advise if otherwise.

Thanks,
Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
