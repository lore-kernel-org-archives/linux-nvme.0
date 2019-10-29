Return-Path: <SRS0=i+iK=YW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC685CA9EC2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 07:54:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CCD20862
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 07:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5QDFNPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CCD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=erERe2EAhhArd/nvZGs6mRQvJbNRu1AsgjmDAHrOfS8=; b=P5QDFNPon0DJxjUyRdVQzayaCI
	tpO27on0kuDOwPuDy68KbPWuIUKqaYdD1zD36S/xzaAmZC1uvd5DKHFb6CL1xV1mrk0dSdXELi5Pc
	B2CrOSqO2ca0t5Ci3nErdN0cXU/yMLjEz3qBEboezFcLA2SO5EVpbCKvao8/rHMc9f7bDII4bumsO
	8Xrq7f4KnimD97njyXc2wLFdPKyB+sotI3zYj80u7l4nA+Yyf+jh/yuwD8rwLKhffHN9LsUyG1UVi
	l1bQttAAG0v7ayJzSlQWV0IicPEzUwZnMw76Qogq5Ep3wDTRNbHGuWEjxdGYNJUyrAUKEEgsoAxP9
	A/CXvXNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPML7-0007YV-89; Tue, 29 Oct 2019 07:54:53 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPML3-0007XS-Ii
 for linux-nvme@lists.infradead.org; Tue, 29 Oct 2019 07:54:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 742BDB498;
 Tue, 29 Oct 2019 07:54:46 +0000 (UTC)
Subject: Re: [PATCH] nvmet: stop using bio_set_op_attrs
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20191029071223.24206-1-hch@lst.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBFTTwPEBEADOadCyru0ZmVLaBn620Lq6WhXUlVhtvZF5r1JrbYaBROp8ZpiaOc9YpkN3
 rXTgBx+UoDGtnz9DZnIa9fwxkcby63igMPFJEYpwt9adN6bA1DiKKBqbaV5ZbDXR1tRrSvCl
 2V4IgvgVuO0ZJEt7gakOQlqjQaOvIzDnMIi/abKLSSzYAThsOUf6qBEn2G46r886Mk8MwkJN
 hilcQ7F5UsKfcVVGrTBoim6j69Ve6EztSXOXjFgsoBw4pEhWuBQCkDWPzxkkQof1WfkLAVJ2
 X9McVokrRXeuu3mmB+ltamYcZ/DtvBRy8K6ViAgGyNRWmLTNWdJj19Qgw9Ef+Q9O5rwfbPZy
 SHS2PVE9dEaciS+EJkFQ3/TBRMP1bGeNbZUgrMwWOvt37yguvrCOglbHW+a8/G+L7vz0hasm
 OpvD9+kyTOHjqkknVJL69BOJeCIVUtSjT9EXaAOkqw3EyNJzzhdaMXcOPwvTXNkd8rQZIHft
 SPg47zMp2SJtVdYrA6YgLv7OMMhXhNkUsvhU0HZWUhcXZnj+F9NmDnuccarez9FmLijRUNgL
 6iU+oypB/jaBkO6XLLwo2tf7CYmBYMmvXpygyL8/wt+SIciNiM34Yc+WIx4xv5nDVzG1n09b
 +iXDTYoWH82Dq1xBSVm0gxlNQRUGMmsX1dCbCS2wmWbEJJDEeQARAQABzSdKb2hhbm5lcyBU
 aHVtc2hpcm4gPGp0aHVtc2hpcm5Ac3VzZS5kZT7CwYAEEwEIACoCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AFCQo9ta8FAlohZmoCGQEACgkQA5OWnS12CFATLQ//ajhNDVJLK9bjjiOH
 53B0+hCrRBj5jQiT8I60+4w+hssvRHWkgsujF+V51jcmX3NOXeSyLC1Gk43A9vCz5gXnqyqG
 tOlYm26bihzG02eAoWr/glHBQyy7RYcd97SuRSv77WzuXT3mCnM15TKiqXYNzRCK7u5nx4eu
 szAU+AoXAC/y1gtuDMvANBEuHWE4LNQLkTwJshU1vwoNcTSl+JuQWe89GB8eeeMnHuY92T6A
 ActzHN14R1SRD/51N9sebAxGVZntXzSVKyMID6eGdNegWrz4q55H56ZrOMQ6IIaa7KSz3QSj
 3E8VIY4FawfjCSOuA2joemnXH1a1cJtuqbDPZrO2TUZlNGrO2TRi9e2nIzouShc5EdwmL6qt
 WG5nbGajkm1wCNb6t4v9ueYMPkHsr6xJorFZHlu7PKqB6YY3hRC8dMcCDSLkOPWf+iZrqtpE
 odFBlnYNfmAXp+1ynhUvaeH6eSOqCN3jvQbITUo8mMQsdVgVeJwRdeAOFhP7fsxNugii721U
 acNVDPpEz4QyxfZtfu9QGI405j9MXF/CPrHlNLD5ZM5k9NxnmIdCM9i1ii4nmWvmz9JdVJ+8
 6LkxauROr2apgTXxMnJ3Desp+IRWaFvTVhbwfxmwC5F3Kr0ouhr5Kt8jkQeD/vuqYuxOAyDI
 egjo3Y7OGqct+5nybmbOwU0EVNPA8QEQAN/79cFVNpC+8rmudnXGbob9sk0J99qnwM2tw33v
 uvQjEGAJTVCOHrewDbHmqZ5V1X1LI9cMlLUNMR3W0+L04+MH8s/JxshFST+hOaijGc81AN2P
 NrAQD7IKpA78Q2F3I6gpbMzyMy0DxmoKF73IAMQIknrhzn37DgM+x4jQgkvhFMqnnZ/xIQ9d
 QEBKDtfxH78QPosDqCzsN9HRArC75TiKTKOxC12ZRNFZfEPnmqJ260oImtmoD/L8QiBsdA4m
 Mdkmo6Pq6iAhbGQ5phmhUVuj+7O8rTpGRXySMLZ44BimM8yHWTaiLWxCehHgfUWRNLwFbrd+
 nYJYHoqyFGueZFBNxY4bS2rIEDg+nSKiAwJv3DUJDDd/QJpikB5HIjg/5kcSm7laqfbr1pmC
 ZbR2JCTp4FTABVLxt7pJP40SuLx5He63aA/VyxoInLcZPBNvVfq/3v3fkoILphi77ZfTvKrl
 RkDdH6PkFOFpnrctdTWbIFAYfU96VvySFAOOg5fsCeLv9/zD4dQEGsvva/qKZXkH/l2LeVp3
 xEXoFsUZtajPZgyRBxer0nVWRyeVwUQnLG8kjEOcZzX27GUpughi8w42p4oMD+96tr3BKTAr
 guRHJnU1M1xwRPbw5UsNXEOgYsFc8cdto0X7hQ2Ugc07CRSDvyH50IKXf2++znOTXFDhABEB
 AAHCwV8EGAECAAkFAlTTwPECGwwACgkQA5OWnS12CFAdRg//ZGV0voLRjjgX9ODzaz6LP+IP
 /ebGLXe3I+QXz8DaTkG45evOu6B2J53IM8t1xEug0OnfnTo1z0AFg5vU53L24LAdpi12CarV
 Da53WvHzG4BzCVGOGrAvJnMvUXf0/aEm0Sen2Mvf5kvOwsr9UTHJ8N/ucEKSXAXf+KZLYJbL
 NL4LbOFP+ywxtjV+SgLpDgRotM43yCRbONUXEML64SJ2ST+uNzvilhEQT/mlDP7cY259QDk7
 1K6B+/ACE3Dn7X0/kp8a+ZoNjUJZkQQY4JyMOkITD6+CJ1YsxhX+/few9k5uVrwK/Cw+Vmae
 A85gYfFn+OlLFO/6RGjMAKOsdtPFMltNOZoT+YjgAcW6Q9qGgtVYKcVOxusL8C3v8PAYf7Ul
 Su7c+/Ayr3YV9Sp8PH4X4jK/zk3+DDY1/ASE94c95DW1lpOcyx3n1TwQbwp6TzPMRe1IkkYe
 0lYj9ZgKaZ8hEmzuhg6FKXk9Dah+H73LdV57M4OFN8Xwb7v+oEG23vdsb2KBVG5K6Tv7Hb2N
 sfHWRdU3quYIistrNWWeGmfTlhVLgDhEmAsKZFH05QsAv3pQv7dH/JD+Tbn6sSnNAVrATff1
 AD3dXmt+5d3qYuUxam1UFGufGzV7jqG5QNStp0yvLP0xroB8y0CnnX2FY6bAVCU+CqKu+n1B
 LGlgwABHRtLCwe0EGAEIACAWIQTsOJyrwsTyXYYA0NADk5adLXYIUAUCWsTXAwIbAgCBCRAD
 k5adLXYIUHYgBBkWCAAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAlrE1wMACgkQ0p7yIq+K
 He6RfAEA+frSSvrHiuatNqvgYAJcraYhp1GQJrWSWMmi2eFcGskBAJyLp47etEn3xhJBLVVh
 2y2K4Nobb6ZgxA4Svfnkf7AAdicQALiaOKDwKD3tgf90ypEoummYzAxv8MxyPXZ7ylRnkheA
 eQDxuoc/YwMA4qyxhzf6K4tD/aT12XJd95gk+YAL6flGkJD8rA3jsEucPmo5eko4Ms2rOEdG
 jKsZetkdPKGBd2qVxxyZgzUkgRXduvyux04b9erEpJmoIXs/lE0IRbL9A9rJ6ASjFPGpXYrb
 73pb6Dtkdpvv+hoe4cKeae4dS0AnDc7LWSW3Ub0n61uk/rqpTmKuesmTZeB2GHzLN5GAXfNj
 ELHAeSVfFLPRFrjF5jjKJkpiyq98+oUnvTtDIPMTg05wSN2JtwKnoQ0TAIHWhiF6coGeEfY8
 ikdVLSZDEjW54Td5aIXWCRTBWa6Zqz/G6oESF+Lchu/lDv5+nuN04KZRAwCpXLS++/givJWo
 M9FMnQSvt4N95dVQE3kDsasl960ct8OzxaxuevW0OV/jQEd9gH50RaFif412DTrsuaPsBz6O
 l2t2TyTuHm7wVUY2J3gJYgG723/PUGW4LaoqNrYQUr/rqo6NXw6c+EglRpm1BdpkwPwAng63
 W5VOQMdnozD2RsDM5GfA4aEFi5m00tE+8XPICCtkduyWw+Z+zIqYk2v+zraPLs9Gs0X2C7X0
 yvqY9voUoJjG6skkOToGZbqtMX9K4GOv9JAxVs075QRXL3brHtHONDt6udYobzz+
Message-ID: <bbccfb41-e613-b8a2-5118-4f3462bdc9b3@suse.de>
Date: Tue, 29 Oct 2019 08:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191029071223.24206-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_005449_910184_E89F4CD0 
X-CRM114-Status: GOOD (  15.59  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TG9va3MgZ29vZCwKClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aHVtc2hpcm5A
c3VzZS5kZT4KLS0gCkpvaGFubmVzIFRodW1zaGlybiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBTVVNFIExhYnMgRmlsZXN5c3RlbXMKanRodW1zaGlybkBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgKTWF4ZmVsZHN0ci4gNQo5MDQwOSBOw7xybmJlcmcKR2VybWFueQooSFJC
IDM2ODA5LCBBRyBOw7xybmJlcmcpCkdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKS2V5IGZpbmdlcnByaW50ID0gRUMzOCA5Q0FCIEMyQzQgRjI1RCA4NjAwIEQwRDAgMDM5MyA5
NjlEIDJENzYgMDg1MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
