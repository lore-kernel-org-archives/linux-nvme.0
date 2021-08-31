Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF3C432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 02:45:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7620460FC0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 02:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7620460FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cf1rzfUrt2Fimeg3hF6HCPJFEJv33oHkzAvAh1ip4LU=; b=Z54O+4s00iCbH1
	Tv1EiTgWb6DOc3zWD1hjnC/L9UQccqMUA9R0dSJKceoQJrvgPQwI4Lt+WNEfsxpe78LTQMxUkwNTz
	d6tw4BE3oQvPpONM8SCH68R7snwmyn3/Smh5l0UpwxkDOxP/d/ZqwKMyUp1kjYThoLXHbsXvVloQA
	MguT+VPZhFZdZtB36HrArSSYLZS9dp1En6aLhDGOrwmJwUW7fBNIOzQIL6VUAf5UegdMzcJmrk0WV
	qtawMyKQpWJRZny0NUbKGmzPjbQdYrjxUZaHJeLg7F65kLZGE/dAuqPH3pLfGSzOUpv3FEJ4HvO6n
	HCCS0IKoqM0Ja3gdYrEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKtlQ-00119m-9g; Tue, 31 Aug 2021 02:44:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKtlO-00119M-Bo
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 02:44:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC2660FC0;
 Tue, 31 Aug 2021 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630377878;
 bh=2FmBRSCNyAQ0pShRlrRNvkkEKV6oXo4tapCi+PUDlno=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sGeZH6Gn0nTnRMYKy6+e/WOEgIMkIeUvRxtse3lBbtHOSgE5FEYv1vm9a4W7zzf2w
 diDF+kzvdtUK69aR5u5Bdu+LsemYwRmVj2GJj31JKoypUUMfbTkzz8Kf5eDQk/4T7A
 0dwGydgpHdWekAeRjJtZdeHhp95dWyqF7Se7oct/mxfdwxxNdhqxK/l9HFP9seTWZo
 +hsdzbdLbg2sR4Tbw1tzduebBC2pytkxHZt3d2LjJH9zhPFmNnXz5Yz9K3bIO5Wi/d
 rm9pu0v3+TY26lNXA5xEfj/NIaKWzW4JYPRjIYsBkTfcrUSbDetuzwuIIMtZ9AQqIi
 QJbeIi98eE3WA==
Date: Mon, 30 Aug 2021 19:44:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Samuel Jones <sjones@kalrayinc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Command timeouts with NVMe TCP kernel driver
Message-ID: <20210831024435.GA4884@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_194438_463891_F46F5A2D 
X-CRM114-Status: UNSURE (   7.71  )
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

On Mon, Aug 30, 2021 at 07:37:12PM -0700, Keith Busch wrote:
> One thing that looks problematic is if 'bd.last' is true but
> nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
> sequence. That could cause the io_work to never kick. 

Eh, your observed problem should not be the above: the block layer will
call .commit_rqs() anytime an error occurs during .queue_rq(), which
should kick io_work. So yeah, I'll look for other possibilities.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
