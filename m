Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00479C433E4
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72A320714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqtA8pXj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODPvI/C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72A320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MQnrUtn3Qak1TO813585WjzzVlcQMykhs2UU4vCkFVo=; b=iqtA8pXjZsVVjgubpWPerqgeM
	PrbxWh3vCzdN6ld6uf02ARN6DbAeFGixeZhbuqS8P/nyN72YVGTyAppmci1D0szSyUUD+Hp78QSMr
	JBb3y1eeFgxl4KvY9DOkDmzwEbEWDdlTSeh5zu/1EOKdbQU9CNSwPT9WxjYj8ySlo88zajMTkIErq
	3rs4Iado48eyZykJmOD564F0/vDwOI0N+hSCSHyEoZ7x7dngVsM0saKa5HRsI8tcrr06a8/xXDIy6
	zVsfOwm+DE1Sj3acUcWrLRLT6Ls+bqN9TFg+fS0wfaNooVUq+ehuwCmjn2oY3Ifmk0UeNDNqL8NFX
	unEeYTW4g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzioE-0000sK-H3; Sun, 26 Jul 2020 15:43:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzioD-0000ry-5q; Sun, 26 Jul 2020 15:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YxEFDJd2LiHUJZHU0U0wj25O0MJBQkRdlwAlA8XnHA8=; b=ODPvI/C2W1BrGgNBObtCWG1xwC
 osulfr3ys4P/AQbs/gAuIRiCMrBMLJzXo9CwVEsOF5iaxywL6at1T3FrK9Yq6JJVBIasO/iZ1SI1m
 LaZi+mnearcwN1o5ze+zMT8kPeW2EdVNAMVPP2kAEeec0dgH9PTPODDGytEU58hC4AlKQJVDOSkR+
 9gYDJG3RbYJ4HDmwp29Xc6t+n3txNkGqjDqp9oB4aYzUuXa1vfCh08D4YQnHhbkQE9oRBwOGowuKO
 YRO/5mmCI3E/2SxsvXM8EovgdsYq0y7zrDzDHfkr3cXkoWIoKOW6BeYIdr4ICJyLrREeDn/VvBQyp
 ksolx8rw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jzioB-000836-OQ; Sun, 26 Jul 2020 15:43:27 +0000
Date: Sun, 26 Jul 2020 16:43:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] nvme-fc: nvme-fc-driver.h: drop a duplicated word
Message-ID: <20200726154327.GB30848@infradead.org>
References: <20200719003015.20745-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200719003015.20745-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.9, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
