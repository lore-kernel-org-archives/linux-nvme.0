Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC2ECE582
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NE3Yk02zl0OgLQV74eKEybtXm5BRY5sEJgX+nMb3zlk=; b=tUmv64mz9gZDe/iHDDDuWXVA9H
	nBK8E6vWgJsg1ExhHqPbGre5XFZ/rEtPuQanwYTCKbchG2jQshwGFCnXIFNnOziA1NJdEMVPmhCJf
	Lp4OFDVheVznxmiApFTXMaPlTeqtgv5TDB1Rj73AZ3D6Oeb8z4nSTJWsYzcqdpc5ZvmYSVmGyK2Ti
	JWCXvQzRCWuAHfJ5j4r9Bs/sSD4HH5dwGlmjd0Gvx37No7P8gUNjUjFgYI8mnR7Px8ErxsG0RMGgU
	7LVFefqCU/1OOfnOXZJR5Cc/j3GAq89URAHewShUubV5Fh014Upnv5kne128WKwySvQ1g2UDGoUnI
	fur7IQUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxD8-000000051OX-3EZq;
	Tue, 10 Sep 2024 09:30:58 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxD5-000000051NG-3vTg
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 09:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1725960650; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iI4mCFgTRtVSXXvpjNNX828qzkcyWopKsuXBovI4jE66bT/w9MAZsi8rziLsI7zRnwQEia9R6qO9oSqpMKvMFTXDWd2YbgY/GQetRgck3Xsulj2YK0D5YI7k5tM/rrbfBQs5OAqL5KaK8O9L+824rQebZonYFGCUfSqW79EZkGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725960650; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NE3Yk02zl0OgLQV74eKEybtXm5BRY5sEJgX+nMb3zlk=; 
	b=hML+07f9pRVeXWdAN7l2Yp2lw8E9QTGO+ykRNX6CtoDOwkwjIb6Zkm0UWqyOR4dHtm4xbUsh59sY1ACnqrwSwdXUCLABq25K77OM27+l6xxuWSHnOnuw2Gz09ybgxSBSREt0tlkwSImPEbxSfhVj3rBn0hMR+EKTcH9tJ2s0SrE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725960650;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NE3Yk02zl0OgLQV74eKEybtXm5BRY5sEJgX+nMb3zlk=;
	b=EB8yH8mD/C2MV+QPeZVtAJRFc7L5rFF1QEeMXzDxDolxkhfAvO12DP5lI6Z1FoQ6
	aefY4tZiCbx3JVLOq0M+u7YRT29u8lDx7+Nz2FC6JAhuh1Wc1cJAMpBF7GMzUjLggFY
	4WfQpH2sn7f183jk0Dn8IqKGDFJlJzbcFR7I9G/U=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1725960618352664.1921359482045; Tue, 10 Sep 2024 02:30:18 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:30:18 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191db450152.e0b28690987786.6989198174827147639@collabora.com>
In-Reply-To: <Zt9bLa4TJT6L75aG@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp> <Zt9bLa4TJT6L75aG@kbusch-mbp>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_023056_069757_E94C481E 
X-CRM114-Status: UNSURE (   9.91  )
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






 ---- On Mon, 09 Sep 2024 21:31:41 +0100  Keith Busch  wrote --- 
 > On Mon, Sep 09, 2024 at 02:29:14PM -0600, Keith Busch wrote:
 > > As a test, could you try kernel parameter "nvme.io_queue_depth_set=2"?
 > 
 > Err, I mean "nvme.io_queue_depth=2".
 > 

Thanks, I'll give it a try along with your other questions and report back.

For clarity, the repro steps dropped a step. They should have included the make command:


$ dd if=/dev/urandom of=test_file bs=1M count=10240
$ desync make test_file.caibx test_file
$ sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
$ desync verify-index test_file.caibx test_file



