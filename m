Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB64CD6E45
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Date:Content-Type:
	References:In-Reply-To:From:To:Message-Id:Content-Transfer-Encoding:
	Mime-Version:Cc:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWzvwncnTxTsTjnPRgvwS/j6obn1Eim9CLk2IWj+SXI=; b=mgcTIbpp2cgUjBl2IT8qTNt7HD
	skDD/YFX+jMcyOhUZMckRs/vbXtSXXzhwnpcy58C5EJZ2w31oc9tInOyIAd1/5FyZXptbf00G0FGs
	bj3lUxadsiCPckiLWQeH46PW6oa15cdKOjYPeVyAUVFgvd+mSr4yeou7BKQ0co0P8Kf3Zhkorjp+R
	uz8WkjCspucisGcAynPPrDeilbI56qEMsoILbN3jw4Q7Nijn7foFcLcPm467hbgT0EYoI0JCkhINj
	/1zd0luu1Q3Za2+03bzerT0hk7cX+XB/5XWjQLcoegjTBSYVQESs1YlO4ycgNNsXTKVYDlLetP0vE
	cpnwV5DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRk7-000000054wc-2H6P;
	Thu, 28 May 2026 03:49:11 +0000
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRk4-000000054wH-095D
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779940138; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cWzvwncnTxTsTjnPRgvwS/j6obn1Eim9CLk2IWj+SXI=;
 b=bCx3owyzoOkOOGQ5ufAAu4Fd0XvAvsdBt9bJUsZtCR5NAcx45RPJFT+Ktbf6330LPa2ezF
 F53wiCJJsLFFDwDSIYz5dUiHpwebaNKYy1lcCbTYzV0B1SM8SFtt4/k5CeBUUSgu5VStxT
 QoP3fG6Nvh4qnC1lgDIho1VNCOHsLufgjWhA5fmeqmRyHid03o2kSE7XM4dg2lldYgXDqg
 rQvK3j+razW5M5hAO7t0XYsohw6YHsi6rFQnsZm3K433OOnBduz2FShszrjMZ8j720x3Cx
 oXEXUbGXJ3/LnwGrmhhhgIiU5+SvpUhizAVFGT/ay/xUBkBDWynMvZfEeZSUlg==
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, 
	"Tokunori Ikegami" <ikegami.t@gmail.com>, 
	"Daniel Wagner" <wagi@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <4b210910448ef2227190f426e97614787d15d32b.e5ce5e1d.af0b.4b3d.a55b.5eff144cf045@bytedance.com>
To: "guzebing" <guzebing1612@gmail.com>
From: =?utf-8?q?=E9=A1=BE=E6=B3=BD=E5=85=B5?= <guzebing@bytedance.com>
In-Reply-To: <20260519134542.1841435-1-guzebing1612@gmail.com>
References: <20260519134542.1841435-1-guzebing1612@gmail.com>
X-Lms-Return-Path: <lba+16a17bb28+07e669+lists.infradead.org+guzebing@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 11:48:54 +0800
Subject: Re: [PATCH nvme-cli] nvme: check MUD support before firmware commit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_204908_167979_4D80B528 
X-CRM114-Status: UNSURE (   3.75  )
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

Hi Daniel,

Just a gentle ping on this patch.

Tokunori has reviewed it, and I wanted to check whether there are any remaining
concerns or whether it can be picked up.

Thanks,
Guzebing

