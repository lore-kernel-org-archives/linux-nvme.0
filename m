Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC48C3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rBEVDovthwvQb1NOFB+eJt5hBj4thTdO2ff3jP2AVFA=; b=AEK4Z1PapMtkBY1Nq7t0Bk/Zpp
	wET9bsIh+8Jq+sRyszVuXTgCjWYhOHH1tCaRQ7OL2WFOc1fTvxwwA6vTPOzIpMRflVREP2mvKRL5F
	F+XnCUjNL6PccG3u/EMU50L1t6Da8zAKbRDwMTFz2lNwRUfApoUnXqFFe4ZzXMn+X1fy0JmAneD7K
	HjhRZdzfBj1aPSrHWULlteffjBL/AqbZQss9p/esLwjPP4ESmG9DQCfHRaU9dThSySdGJjowudvba
	883VpIqz8fZLnqNlNn4XZSksFPCHTMI9H7a0hSlQ0SsAD7IBqDSTt3t9PA0pwn7nE2L+F5Q3zVOFr
	0QCN/mBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0PW-0000000DDPf-1IB9;
	Wed, 17 Jul 2024 08:53:18 +0000
Received: from m15.mail.163.com ([45.254.50.220])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0PS-0000000DDPC-0oOf
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 08:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rBEVD
	ovthwvQb1NOFB+eJt5hBj4thTdO2ff3jP2AVFA=; b=Uzr2onGFcbEdb2YmNKsSZ
	RIbFs7DdPW5/ppuMFvduVt1B4A0pQunZTniHCJJArqRYzwfvsBaH37fUH/nkY3xr
	t+aFaaAixF2iV7WMH6f9WiWcwR5WwT/bShZ4t3Uikd292waUdnNMD2TplzSs6wiK
	ZnI6NIP7X2hIoJ8FlJ3nTU=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3v_RphpdmH80MDQ--.56246S2;
	Wed, 17 Jul 2024 16:52:57 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp 
Date: Wed, 17 Jul 2024 16:52:01 +0800
Message-Id: <20240717085202.104722-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0c4c4365-2c2b-4985-bbb1-5d58bf332671@suse.de>
References: <0c4c4365-2c2b-4985-bbb1-5d58bf332671@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v_RphpdmH80MDQ--.56246S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO5rcDUUUU
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAwfKWXAl+MsjgAAsZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_015314_688178_33DDADE1 
X-CRM114-Status: UNSURE (   7.17  )
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

> On 7/17/24 09:52, Ping Gan wrote:
>> To define a module parameter use_unbound_wq to enable unbound
>> workqueue to handle TCP's IO.
>> 
>> Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
>
> Please use your real name 'Ping Gan' as the author name, not the mail
> alias.

Sorry, forgot to change, will do in next version.




