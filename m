Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E377EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References
	:Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBffCw7yxR08203yqk5YHoqQ7XS/o1T3z5vSH1C4j+o=; b=iOgpYBF07jlrnyw/Oj7yD1sxtA
	FH2/+L2GQLy03kumZ+YjhDrX5o/b336xIN9+CjJa9dKDxQiGf8UffSmhL5Zgv2CkS3ZuFG0Pfq9kb
	tMSUs39rT0s2xREUjs4mkNTmMh+p8lza7dYIMRkYhufEox24u7ZHZQ9EdNR3EATmKqhCR1U4yUmA6
	uSTdkUQl9OUXv5TrIVPy+D6d+GKTyveU0ff9C4+3ejAIgBxT6tScbto73xlGUYIzgC0fmJopGwHW1
	Jp2+/pY6c4lL3i24Ny7EhqdIQ9qvhhHsVyaoslkwqaD/J0HoVvhvngGvYF/8b+UX0YQ+x2TfMikBk
	0NULdX7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSIdA-00Cu5a-Hp; Thu, 10 Mar 2022 13:15:00 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSId6-00Cu1P-44
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 13:14:57 +0000
Received: by mail-ej1-x635.google.com with SMTP id dr20so11916654ejc.6
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=vBffCw7yxR08203yqk5YHoqQ7XS/o1T3z5vSH1C4j+o=;
 b=NSnsv/YlVRnmwl5NUdxZb3e0Y7KZN25nTRQpW6Eb46hTerOHq2gdD5i+oW7TuvdyMe
 5eAX4iybzViIwtwWYCAg6tiyMKEct/4oEVSw9jqMvdp4RbFJrESldMSUsozmsINp5dfj
 xCEHcalG528i/dXvOFvDdYX3bAlZkdaPH9Ae8POz2WhQwTe1l94CE9ofsXBj7JA4PwGE
 Ur8pAbRMPKqzrcRAXOxhWTdPYhHnkAxingagXm4pqawvBdOkuFAjAsG50AzGtPzQ+wYD
 R+F5rxNSqY8x6DIfZI+I2T8DaCEejIvX5w9jaio20Yk7zwA47V0CMkEmxkU+CkQgg6UU
 w9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=vBffCw7yxR08203yqk5YHoqQ7XS/o1T3z5vSH1C4j+o=;
 b=szMNmA+KwqeWiDg1ft3wjH679iMfJzIVJ57gorE9CUWfFbCg0xbmWXozJcBvceq+rZ
 xyEzJ0oOj/KLFvX9vSicrKFu3wmaCoR1Zqcj9hLWQoQrGArqZHpipCojsaPSM0IHqzeD
 9g40enyDchjKMDDLnUXgqHFbr3e7RV05BvznpAqVb39afVJRbUHoZiChMw83Jcyiu6aO
 72GJX2Nx1sDXMvJqmKdHv8QxuAWhCs5zdtCg1qXmERoK7T0ZbxGTn89yVVPTpMuNug65
 AB81a53sZMpVHisE4Vm8+/0Opoep0DKj7yGcE9spHkblTsUjObd8NbboKHQLf6bX+Lv2
 HsTw==
X-Gm-Message-State: AOAM533YkE//C8AAVCmJv46WNU5M1zIXnX2YuqW0XciMTXX7rYCpCJSs
 WezyhE5GRBYx6NkjUx12VPBYjQ==
X-Google-Smtp-Source: ABdhPJys3+fb3FNd4PHh5hvmjjJTkorU7UTjdX+OLN9i22AxgvCT0Aec6WaiKyDdI1X7RWcunfDAaw==
X-Received: by 2002:a17:906:bcec:b0:6da:9ded:2f7 with SMTP id
 op12-20020a170906bcec00b006da9ded02f7mr4097629ejb.113.1646918094002; 
 Thu, 10 Mar 2022 05:14:54 -0800 (PST)
Received: from smtpclient.apple ([2a02:aa7:4007:6673:70d2:2604:fb1b:500e])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a170906739600b006db726290dcsm1576050ejl.217.2022.03.10.05.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 05:14:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Date: Thu, 10 Mar 2022 14:14:52 +0100
Message-Id: <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
X-Mailer: iPhone Mail (19D52)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_051456_264474_2C7C22EA 
X-CRM114-Status: UNSURE (   9.36  )
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



> On 10 Mar 2022, at 14.07, Matias Bj=C3=B8rling <matias.bjorling@wdc.com> w=
rote:
>=20
> =EF=BB=BF
>>=20
>> Yes, these drives are intended for Linux users that would use the zoned
>> block device. Append is supported but holes in the LBA space (due to diff=
 in
>> zone cap and zone size) is still a problem for these users.
>=20
> With respect to the specific users, what does it break specifically? What a=
re key features are they missing when there's holes?=20

What we hear is that it breaks existing mapping in applications, where the a=
ddress space is seen as contiguous; with holes it needs to account for the u=
nmapped space. This affects performance and and CPU due to unnecessary split=
s. This is for both reads and writes.=20

For more details, I guess they will have to jump in and share the parts that=
 they consider is proper to share in the mailing list.=20

I guess we will have more conversations around this as we push the block lay=
er changes after this series.=20=

