Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8170C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:16:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6819223A33
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819223A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wkYV8LRaKrjmu/OvN63wLqyzQr1HjfUlcPU68k1KIy4=; b=DFW2FEuAVKtun2uSj5Na65/DU
	1rj2WW75Gw/EZ36JH2zqWbuv0/amyYfwGLPfX90prdetqNdPty6jO19yhJzQxjL/NN7+frVEBjFNn
	PBxKuJsL1ZanQrzajWzfcZJhd9R1KaVFZJGv5D/KPdalNvHXbbziom7kBINqeDqRLEHHSUWEpl+9b
	SxNrv///vS2HvlB6wRrQEb4BVSpH1oGQe6ojvySVnyhArAWqfl3XzL9g9hN/6khfX7EnIR7veFi0p
	s1oPuSdHxcUqUN/Bc2K6KGd5ZNqqcwfrjcKQmlkBwSH6IqogOfQEO+EprunDnnPEBfoHut+EnTgqF
	yo7s9dL5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdnQ-0005l9-1d; Tue, 08 Dec 2020 14:16:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdnO-0005kd-BK
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 14:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607437010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb75kL8jRQ3nTby9ESwgjqPc4VgYmcGLE2DEwsRt6wQ=;
 b=BoIX3A010hvcnzL3WWqwQCD+bbtr5JZCxSSknnCZ8JLOFP8QKUMXi5vwIDRQuNcQZXl1lR
 XhTl4ulSxPdHEwjb0kCl3TDMAx+vpFUBi7/92z8oRJfJyuLmgUSEpRRpo5kOvozrXkYo0R
 J22KXWPfcOmk39mA7nrMAMRIyO1KTHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-o3eF72enOl2e2tHOaB8ztg-1; Tue, 08 Dec 2020 09:16:48 -0500
X-MC-Unique: o3eF72enOl2e2tHOaB8ztg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 060078144E5;
 Tue,  8 Dec 2020 14:16:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F255360BF1;
 Tue,  8 Dec 2020 14:16:46 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E9AA718095FF;
 Tue,  8 Dec 2020 14:16:46 +0000 (UTC)
Date: Tue, 8 Dec 2020 09:16:46 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <1233734261.23639532.1607437006766.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201208140440.GA3730@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201208140440.GA3730@lst.de>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
MIME-Version: 1.0
X-Originating-IP: [10.64.242.69, 10.4.195.9]
Thread-Topic: nvme: Added QUIRK for Samsung PM1725a
Thread-Index: uoBkNhl+yMoX6Ch6E8W95IBRIREJWQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_091650_469064_B46AA5F0 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks & regards,
Gopal Tiwari 


----- Original Message -----
From: "Christoph Hellwig" <hch@lst.de>
To: "Gopal Tiwari" <gtiwari@redhat.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org, dmilburn@redhat.com
Sent: Tuesday, December 8, 2020 7:34:40 PM
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a

Thanks,

applied to nvme-5.11.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
