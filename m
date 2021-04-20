Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0138BC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:20:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89219613D5
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89219613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6Psyw6BoR+E0TjjwP0K09bmCrXOx9mBBWijt7kmCPpY=; b=lyt5c32KTfg5DTzZl2UGfWAv8
	GCz8qaobBB8xqQuCT5ooGueTRkrdRyVxA++XPKNlJhLnIx07mzmbfLWLPuwIj6d/GPC0EJ2ZLG6qk
	Yn5baktbIZwJ6uLh3lvxfxIH9oIhr4+l5Ck/uj/cElEgKmnzqUWnmVlRf0bZ2q4uoGTtWGfFq3RbQ
	tVGCOhDCoTKRbUqs5dtoLr7xDg/b5IOvqmyaMglRc7g1mCC98r3iKXjnV1YYUCkcKDawGVekgwZ5s
	FpVUz1wTK5QoEk20t/2Sth40j4QFmIuFCFfgWNrJEl3NK+qLVDn2Sj/x5zAqusGwijCpB7MQSS4Fu
	zy+SqYs5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYwqx-00D0MI-FT; Tue, 20 Apr 2021 20:20:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYwqq-00D0LD-7P
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 20:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QUzDNiX/itAkjg5r1zDyCqYXlhx9ApzbrMws/48vk0U=; b=cuCUNCUdC24ZKaHC0BAMCVT/s/
 qnOfsI7fy9Oj7HNgfg/aspAgi2lF+XsPTQwIJsMOCQHGfHFXFmODoxjSIcXFW7/8GIZE4X68xTiDK
 2h3uj/zaSczvID6N4aT7lBhaQkaa2WZP2PSLPoHOhGQdM40TNtAlTuUS7QOMpMaU8uPwbhuFosfQO
 2gEpCNV95bKGFhuf2ZqodOVOoFzlUo4lXRQWTG7eEPsAA9Xn6cIdajPUD+w+65JlRWgD4VftzyNkl
 cGnkHAg+OT3G244MMyC5QZj9KLAi/nT04zz/aGTGK8QVV+hqJVdO1IlR7RZKff2olwxJAP2QUj570
 kIifdtmw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYwqm-00CP1T-Rz
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 20:20:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4DFC613D5;
 Tue, 20 Apr 2021 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618950000;
 bh=g9TVOTElbiNeL8IzWGy+zEkv3ozMZtmyGJPyRwC074s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h0EN7cOspNYjF5p6nZDdKx7XFOauI5PjtvBp7FQ+fGJ8Z14pW+KC/r5LSt/gNv3ho
 MfXf1DoRsMKLxOO3O0Qq+U5x5AiiUttApg/ckIUwKfDNZI5iadKXJP/uVSGeSoENGd
 7CQz5Yd/Atpsq3MFYvtnNvmJxjlf3R/4Sc2qAYtfl6i0kghZyeQ+BkDCMTKd49kJ2F
 BdcZyEJF99MsJeNxpxBPtr999rGGD644EcPaZ7evLieZUyVzwpX0zw2iLdhzmDvMnz
 ySITLUrZwjmVR6WUZmYkAzL5gYNHEvUXKLGXA1TwqK39tjQrzc8VOyZgDYoXqTt5P5
 +Y0paJ2QY2xzQ==
Date: Wed, 21 Apr 2021 05:19:54 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe CLI Version Update
Message-ID: <20210420201954.GA18702@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB5656669415965F63F56B8686EA499@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656669415965F63F56B8686EA499@BYAPR04MB5656.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_132000_962545_5E9C9A7A 
X-CRM114-Status: UNSURE (   7.44  )
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

On Mon, Apr 19, 2021 at 04:20:31PM +0000, Jeffrey Lien wrote:
> Keith,
> I'd like to request the nvme cli version be updated to 1.14.  It's been about 6 months since 1.13 and we have a lot of fixes in our plugin code since then.   Thanks

v1.14 is tagged and pushed.

Future development based on this release will be placed within a new
(to-be-created) branch, and 'master' will bring libnvme integration into
the fold. Hopefully no one notices. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
