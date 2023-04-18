Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99149C77B76
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 02:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3gwOs5yZ09ScguDMjDgLq/mG1QfFQkfqrF7Mazy/tQ=; b=MhgeOCKaIzhLZtSnExh/KTabE9
	rACA93aph/CmZISaQashTsZiUrVgYm3UW2YvoE3wUxetJ1nIctArqBGneHruok0Pl4GFYILVfdhdE
	Ac5h5/ggWCfYg8Ay5NJbDO1kojSJtfEgeruZ9f5Q6avY1cF7wjNd8FWc3CYxVSsdWy3szTpIlgro7
	QKvcxm79kAWQGCBkERJi+CR19QpHYP3le/PBEZ7638EE2sTj5+7ee00Q3cO3mmFFJGZ1ezdXb3BQr
	JgwLLdTMsd8RXFFaIXB61mHVO1x5OvBpUH1szT5WZzX+sxuKwgWSRcMNadE0e/SZOg5iTG0Yi9T12
	1ga1CYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poauw-000f1P-2N;
	Tue, 18 Apr 2023 02:18:02 +0000
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poaut-000f0f-0W
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 02:18:00 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 8AFD25828AA;
	Mon, 17 Apr 2023 22:17:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Apr 2023 22:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1681784272; x=1681784872; bh=F3
	gwOs5yZ09ScguDMjDgLq/mG1QfFQkfqrF7Mazy/tQ=; b=ev8PFUk1g/X+m6yY7b
	yF1/gOiLxzYOI7zajEx5zsek1CaxBvaHJx4pRjcY5s6quCMfk3u9Q4uugRRlVeNI
	m7917LE2AUFKA8ctb89vpKD82lEBILJksKuUzfp7OY28DQfPlLGzYItd/KHgHXhL
	ho12jny+sxo7nxhXda2g/6QciNNIxreiMKSsS7HoQmPkQrRQgUr9sIq/Ym38kAEk
	hm0QdcvRy9EQFS/MbAsIqjowi+pk3db7Sv1A5H2CNPx9mfdmrP0agffTUIV9Od4B
	eklv3KT3UsXOUNY+iYmQq8kEEirpnOnkRpbX28wXoHxzH0hSUG0t+do5vd+UpJYS
	i6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=ie1e949a3.fm3; t=1681784272; x=1681784872; bh=F3g
	wOs5yZ09ScguDMjDgLq/mG1QfFQkfqrF7Mazy/tQ=; b=Z1ZtL9rSnbkP4cfLdTe
	J+yKVOJo7R39npGanpuXIMFUG0kdiXxkta0jTqcNMYqwK0CpKIdMglCIL5BvToQj
	SX4cUCHnfeIZS8IePo9Nv2lt9UhFbZuiLidczPTwDOEvcJdN6S+Vdg18Vmu04vMQ
	fquXBIyGxXPpvfhh13b4DQ/nW5DLGrcoZYNmf1g2j9ikAWiHk1d+3Nu24o2Yg2hZ
	faR90NSkF+fIcToMQSGJZMmjd9HqiU2ZPixYztQfe0mlpkZpncQDW6VUXP+3H32u
	4uCGC4EILSfKueg7Oo8E11bdbs9ykrql1gQmAngsPeLAD7AfQzcbU63Qjnp3Eh/Y
	DFg==
X-ME-Sender: <xms:0P09ZJUgQ-dSQgzP0mwltSh8WD2k0rWTH7XwOZ1fVGiLyCwQ5-HV6g>
    <xme:0P09ZJnZLE4N2oegFeVlS4_yeImlNzZD8bxAPuza8Gn63eSAcIYA-cZtXciYfVaKA
    xb90fXVD2ATMQVZTC8>
X-ME-Received: <xmr:0P09ZFZ0BNMmVSEfqMMzBAhX63rnqX0HfhAbVaiI4DApezqSTuaYcDiThCZunHjHF-fXSo4YzPNPjMtXysnkpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    fstddttddvnecuhfhrohhmpefuhhhinhdkihgthhhirhhoucfmrgifrghsrghkihcuoehs
    hhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dvgedtgfdvhffgkedvkedtgfefleejleeggfekudejieetheeghfegtefhgfehheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhinhhitg
    hhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0P09ZMU4lvHxLck3DorXKCQarj5tvNnBP8E0AtB41IDikC-CTUfxPw>
    <xmx:0P09ZDnu1juapsyUXQyzJtbySB8J361xXetIRvM2Jz5KcWllDveWrw>
    <xmx:0P09ZJdA_R9NbeRJbLEPiMwKB8loFgWbpofH0J3sPA5rwPsT31iitQ>
    <xmx:0P09ZIwpssZXYOmQEr6wM83c5VHL2i0HSFkSs0gVf_BYb9eltbRkI0F1SVQ>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 22:17:50 -0400 (EDT)
Date: Tue, 18 Apr 2023 11:17:46 +0900
From: Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To: alan.adamson@oracle.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Message-ID: <26coaxpjtu5vkzxp6tp6wysbzydvg7mjptudbwnxl3xthzxdh7@kl32wqat4z6k>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
 <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
 <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
 <lhy27pg5my4fw7a7lyt5ag6zms4vnnaoab2laylatjqwkckdzv@55ebsbgtgpbs>
 <3216ff1f-ecde-967b-75b1-7da643570ed9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3216ff1f-ecde-967b-75b1-7da643570ed9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_191759_625078_5CB4DABE 
X-CRM114-Status: UNSURE (   4.07  )
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

On Apr 13, 2023 / 10:19, alan.adamson@oracle.com wrote:
[...]
> Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
> 
> Tested-by: Alan Adamson <alan.adamson@oracle.com>

Thanks for the review and the test. I've applied the fix.

