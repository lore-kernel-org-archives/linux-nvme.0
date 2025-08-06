Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C521DC87FCA
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKVLeGga4ERqio0t8GPfT2uuX3qFqhHR2Y5CjNmVD+c=; b=Zj2+YtAS4utuLPI3XGwLJLouNv
	FmQN3bhfAJsrrXKiPQI75izPb5UHrcS+b0gxREg8FbPhptbMIdfBw9bShTvYwuqaYf6GAwipH+ljp
	pEQuLRgz95eiTdgI+qP6b1VepMVCEoFPFbsUxz6WAiTWFHfrbmc4PVQUIFcMIKBiriaaH1zh5sBes
	L0wA9/gPOa/YShyN2+QAT1ymBMjsjxb+Mcp+DxCjoWrzISZRJdWyKHQDUr40KSLgc2T1PhB7LE13j
	QKMMvX+HYHGyaN61iMWE8aDn/CvcCbqQZNDXGpqysQR9tpWxcFai4Ja5X3iFgx3caWvHbEdSLYv6n
	puw+vIvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXyx-0000000ERBg-0bhR;
	Wed, 06 Aug 2025 06:50:39 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXss-0000000EQkp-1OmA
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 06:44:23 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 27d2961c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:44:20 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:44:18 +0200
Message-Id: <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "linux-block" <linux-block@vger.kernel.org>, "open
 list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu> <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
In-Reply-To: <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_234422_749083_E3410529 
X-CRM114-Status: GOOD (  10.23  )
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

On Wed Aug 6, 2025 at 8:22 AM CEST, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 8:16 AM CEST, Maurizio Lombardi wrote:
>>
>> I think that the problem is due to the fact that nvmet_tcp_data_ready()
>> calls the queue->data_ready() callback with the sk_callback_lock
>> locked.
>> The data_ready callback points to nvmet_tcp_listen_data_ready()
>> which tries to lock the same sk_callback_lock, hence the deadlock.
>>
>> Maybe it can be fixed by deferring the call to queue->data_ready() by
>> using a workqueue.
>>
>
> Ops sorry they are two read locks, the real problem then is that
> something is holding the write lock.

Ok, I think I get what happens now.

The threads that call nvmet_tcp_data_ready() (takes the read lock 2
times) and
nvmet_tcp_release_queue_work() (tries to take the write lock)
are blocking each other.
So I still think that deferring the call to queue->data_ready() by
using a workqueue should fix it.

Maurizio



