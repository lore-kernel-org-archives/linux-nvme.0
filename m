Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CDDC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FLMIyM7qOCOVEMp1o/ltkgnLeuU0ZBlT9xWiZMBZ7Ag=; b=Oz6J8tyYvuYnyP8NpMRMRksQLH
	DxD1K+UulpyuvhduTQQVqMdAm1Np15wT1LUyxpvZAbkW8nu/IBBWVIDY/uk36pU1O48NRqlUONRGr
	71o/jOVejKWo25sUVXkzK1biIVrTvK2neakVmn5ubOwtiaRL8jA4fqjZKxLfCGaDB0P3e+nWiF4Bg
	90TnYiBhd/0UTGhtLOl52P35sRCiTVz+m64fQRtsV9Gy1OemOICmZ361ak+FtgH/HRAVYTeoE5asC
	88qJVx2MQoc9YyUTlP1RtWFeqNTolnRRFwoxsmwgvZQLqZ1sios5bRNiAo1Uv6pSnq84BxA6xRX4/
	QuljsMfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjAu-00FhQ4-3D;
	Thu, 16 Mar 2023 08:41:29 +0000
Received: from mail.paretdee.com ([141.95.17.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjAt-00FhPM-0F
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 08:41:28 +0000
Received: by mail.paretdee.com (Postfix, from userid 1002)
	id 49FDCA2C83; Thu, 16 Mar 2023 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=paretdee.com; s=mail;
	t=1678956070; bh=FLMIyM7qOCOVEMp1o/ltkgnLeuU0ZBlT9xWiZMBZ7Ag=;
	h=Date:From:To:Subject:From;
	b=pm6P7jBwHfYYA1yj0xhf/Zkdo2IANsM/i4qAf8yq9nh65qqXFbs/HaoE3NRw0naJV
	 RC0UFjYV+GKASGrhipTu5Chq2M8bbHgRTx/mVM13Uf4gq+ybfswbh3aFLigyEQBMiB
	 kL0znuyMPJNlJeQAiyaciZL2pD0pwvueEzynGmyg2PbrfGboX8WshB/iuITCdnLnw5
	 9/98j9/NRi9PnF7k+9Gs80u3+3/t00hbrDJcZZ0GnNgT90RjMAC45P+YgYSxDLPbQ4
	 pye+JTGk0Ynk512H3AuIFUzlLrihdoWakCBaQ28JPIBFsXNd28WVKszqdshVyzxZqg
	 PxfV48ORtBKgg==
Received: by mail.paretdee.com for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 08:40:33 GMT
Message-ID: <20230316074500-0.1.5h.clyt.0.6c8e61gdiv@paretdee.com>
Date: Thu, 16 Mar 2023 08:40:33 GMT
From: "Zbynek Spacek" <zbynek.spacek@paretdee.com>
To: <linux-nvme@lists.infradead.org>
Subject: Rubber Molded
X-Mailer: mail.paretdee.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_014127_261861_125F6D84 
X-CRM114-Status: UNSURE (   2.24  )
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

Good morning,

we can offer unbeatable conditions for the supply of various silicone com=
pounds and rubbers, liquid silicone rubber (LSR).

In our assortment you will also find cross-linking agents, stabilizers, d=
yes and individual silicone mixtures that we will develop for your needs.

Do you want to know what we can offer you?


Best regards
Zbynek Spacek

