Return-Path: <SRS0=U9tF=ZC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439CBC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 15:19:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEED5206DF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AG1IeHd1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=overt.org header.i=@overt.org header.b="eYOM8wFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEED5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=overt.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bDGggcZtZufWFWztpS98ACYPt3B34UjvEe0QXTp5VuA=; b=AG1IeHd115stA1
	qHn4p9n3zx4uF2bRiXBwCPcNM7WkHEwYDJcfSJQyBpXPzD162OYLQ/uJDLq3loqJy+HAkE49YwWPG
	9ZZIZxJyglDhaacD5Onxy20qBYQHcK6fv5MSBq7oawkRZ+puYm5gtFeiGPtm5hGJXEnG5P/clYj40
	AT67kEpwWsPdtKaGb8hVtCTKA+WfC8yVAixAMbbtJsP1UoF7Fl9XdK4hhqbeVNECAVd9yeAx26Ial
	rN6J2eZYrYiZBTbP1x05dlet5gu72iDuTnR4fPOmXuEtqlEzn6WG+O7Fl6WOEr3JvPLf5bI4pwjPm
	1PktzbGJ7aVlR/XWqy4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTp0D-0000Nq-RQ; Sun, 10 Nov 2019 15:19:45 +0000
Received: from mail.overt.org ([157.230.92.47])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTp0A-0000NM-LT
 for linux-nvme@lists.infradead.org; Sun, 10 Nov 2019 15:19:44 +0000
Received: from authenticated-user (mail.overt.org [157.230.92.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.overt.org (Postfix) with ESMTPSA id 0BA523F20A
 for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2019 09:11:04 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
 t=1573398665; bh=hGD9VwzwJXWjFfrXt7n1JnGsY3YrZFLAFC/ynypd7xU=;
 h=Date:From:To:Subject:From;
 b=eYOM8wFBF15Cb5vAZYzlYMwgMc3yhY5Fvcl5zJeoPWO5Dk11AG7/ZpJbutHME87hs
 YnQVnV/4dugdAWds7cede8HHVQIwAo40/ODIVNx4d7tOO+a6VkilpE3DIWu6k1g/pL
 UK7Nlub+2TcLIkD35UKpxZlkz5ZbKzJOcq43y/fleW8AHQvZKmviRpnATI0dYoAjY/
 ox6CY4vafa43E1wCY0wGSeF/fwm9feiJdMFuJTj9HAVZaHbuCQjHZ14lycYqdfTfld
 i/ok36n0qwDW41oivgFF92gklmwjTip9yHpx0nj0JGjnJM41hHlahrsMpezX8Z9Apv
 IZgK39v9nBLzg==
Date: Sun, 10 Nov 2019 07:11:02 -0800
From: Philip Langdale <philipl@overt.org>
To: linux-nvme@lists.infradead.org
Subject: IOMMU incompatibility with discard on certain devices
Message-ID: <20191110071102.2b94fca7@fido6>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191110_071942_796932_C8C0A5CC 
X-CRM114-Status: GOOD (  10.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

I'm writing to highlight a problem that is affecting users of certain
nvme ssds as discussed here:

https://bugzilla.kernel.org/show_bug.cgi?id=202665

The problem has been narrowed down to some devices always doing page
aligned reads when reading the list of segments to discard, rather than
reading the exact size passed. When an enforcing IOMMU is used (both
Intel and AMD systems exhibit the same behaviour in the reports), these
page-aligned reads are rejected because they are larger than the actual
allocations.

In the bugzilla bug, a patch was proposed to add a device quirk that
ensures the segment list allocation is page-aligned, and this solved
the problem for everyone who tried it. Another patch was offered that
simply always page-aligns the allocations and perhaps that's
actually better?

If I was the patch author, I would have sent the quirk patch to the
list, but as I am not, I can't sign-off on it. It would be great if
someone could look at this, and we can get a fix committed.

Thanks,

--phil

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
