Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157AEC0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/+GwkxIpn/9+ROx9DbGMMcOd3MQCVuvzdX3xAm83Tk=; b=YnEgnAxUybkbAr2obY4JljWpwd
	0lwgQ1AbwexePFkFy43wiX7OWiFzbvVvYL9iTiGo+Vl5zRnpac621ZaiFH3SzeySqmjEQNgOKVtd5
	Dy/gUU0IQ+5xhZCUR6WTAjsj0+OdnhbVBxLn9Da9xtyv4YkQFqkGxdq6BnqMyWIsVet2p+ittQwx0
	eMESd6fzHci4MzxJeYEVkNSXPCO3Ia66fjli3Z7G7EIz9Iy6/lBigOUazNelnq+I7X+xeqXt0R6ZJ
	VOJetmfNnGWLg0kUKnn73L1RK/hoh8udJMdwD5Qisch9iGNHcsseYXl05oredP/WLEsSkmlNehT0f
	MaulITpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgIW-00000004IRe-0Pq3;
	Tue, 28 Jan 2025 07:46:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgIU-00000004IR7-13oF
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 07:46:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6D5168D05; Tue, 28 Jan 2025 08:46:05 +0100 (CET)
Date: Tue, 28 Jan 2025 08:46:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
Message-ID: <20250128074605.GA22567@lst.de>
References: <20250124082505.140258-1-hare@kernel.org> <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me> <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_234610_431773_34417E6B 
X-CRM114-Status: GOOD (  11.71  )
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

On Fri, Jan 24, 2025 at 12:09:31PM +0100, Hannes Reinecke wrote:
>> It is also unclear how the above patch is causing this.
>>
>>  From quick look patch itself looks reasonable.
>
> Should've said: this is the fix to the reported blktest failure
> on nvme/058...

Can you please resend with that included?


