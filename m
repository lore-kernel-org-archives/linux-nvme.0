Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EC6EB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Jul 2023 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:References:Cc:To:Subject:From:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=; b=EzQUC4WTDDk7/GFSWewGd/lOof
	CILQ1tvVB0MyfMK0Db00XKuhjY93tZcNxNybZpSj8LND8eGpK8/qTl21PyQxuoUEm5CUkj2P1WICr
	qvag27EO2aV3+GF4Ad4jzo1AuRFBgtvAZsynspRRb+u6GCX26xngfQmk0pDiRcW6gw3vi4mjP5cUV
	8LanVo8JweRU83wsUO5vMrFwQrVb6hxMDGQ4mBHh/ergIFk52UDz7TiFHJoUXu5n4RZOHa/wTulR/
	k2I17qRMj0yBNLxQCtSbpIthrKpqydFGfe8fiDz1d7adGb1M80WTjQECDTihL7273DdDLa9NKr8SR
	6JLNrcFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qL7SE-00EYn6-37;
	Sun, 16 Jul 2023 19:30:50 +0000
Received: from abi149hd126.arn1.oracleemaildelivery.com ([129.149.84.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qL7SB-00EYkA-2e
	for linux-nvme@lists.infradead.org;
	Sun, 16 Jul 2023 19:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=hhYQHeWeU3tWLwkcoWUkS7C8RqLLTN6gdAl5d6RHOsD6mFDYNN8KTBTyAWR1eU5dwokmiavsFfW3
   vaVh+c1pvIKb0/s449uLlfHT75ASed294nTe6MVD72MtEHaIUizStnmLW2MMRLDGQaOOYbTZRfdx
   4TG6s9sGdM1hM7dXn/dvWh0YijIczoFWwn+0CR0uRS5EsoUOBGipTodMsYTCzc4OXH1UeQSSspC/
   gL57Z5mEtHYUIjERn1ZS7VYl6DQUgwMoM94eezODEqvOMNDYxRjbPt/BK+qPiZNXd2ZCL8D/MCJz
   tGab/fg6WDylUfGRsWgR1YD0Ns8z2bMUR9lz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=MTAHRUN67jyzpHcQ1EHcYebCrL+Zrea6rPHGTQrZrZydIfK3QTKJUkEdwF/jYpwcsSLEzv4ndYAy
   oNGWRfebaxV6iVN23mJ2mWABO6rDERU7zT81tw7cEHeVILT0oqndir+WvHhjf25x9rzdqd0FYMe0
   oR/PUQlQ7NRn6jcXvDR6MuPaC8PYjMHGsU79z+go/9wHjSqf0ku2vqKsDXTQXG9A8B45KrinkjVt
   aTmxrs0AnN21QifSEZfaH58rgBxE7PbDE6Ycp8ifPWiF5r7oCFuAliujU1ivrOT2xH8XWwV6CK9/
   BOCgtNbV7xdiyA/SnSWn6kQIB2wROYijXjCZLg==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RXW0073XM78V730@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Sun, 16 Jul 2023 19:30:44 +0000 (GMT)
Message-id: <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
Date: Sun, 16 Jul 2023 21:30:41 +0200
MIME-version: 1.0
From: August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
To: Nils Kruse <nilskruse97@gmail.com>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-language: en-US
In-reply-to: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEqHmCrKsOnH195OEdwrfg9FTxZzACbRkpk03nDz2o7ewDk7A9Vjq6UenQjGOdN
 kAaYT+day+D9LnofH23vmNDd3QZ5lX8jc6qJxslcQ006oqP90wZ9QKilOt1gwM7l
 UtinvVLkVFxGB1HETrNx5agYvtFyYIU2CndsCvlSydwYOTM0HzLCiYOro+bOviy8
 uZ94KRrB1POaFoCe5UcsWuJSiPFYIQtXGARjO0eMW4cHDo2Y5V80cQlj078nJo3f
 CyF0WdLaIfsj0P957wTU9z+8FMh9q43sxYL3LzAulZ/jpUX2OuNssxmufZRESD9k
 Z5ubXuG92NTZN4H9U+0FLSahJ04UUKIvBmiIimCnnnPAynQYVc3G1JjlQiNgtKfA
 Y1Onx+Ju66ub5pjnmE4ywg61+1rK5XwkHJbwBoQUnYaCX2nm5w+/C9l9gVQ8zhHE IIdbe0VC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230716_123047_857276_A03FF401 
X-CRM114-Status: UNSURE (   5.63  )
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

On 2023-06-11 13:41, Nils Kruse wrote:
> Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids 
> for disk.

Is this the same issue with suspend as [1], [2] and [3] or is it a
different case?

[1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
[2] https://github.com/tomsom/yoga-linux/issues/9
[3] https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/

