Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1301C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pnxFN7k04CTWSREtHTBvavOqXLmX9IQXMn7DH8JdIEE=; b=th5udDkBiYx9W4gglKMQ654/wl
	JHACRaMT5mpcwEt8LCPUo4G8AbAfK4fGJtnOyKRPX1fn2tqIa5BoracNyd7SYCYr0JXILXteRbsF4
	b4S6u0DXGminxjr1VzOu9yz04QAuN1CsKRqAbvGKTg3YlwV6xjWjQCe+dbZlC7eySGp+a/NLV2bz2
	WeSE2RSu04rth4oZB9lr3TyRVbDn0gsMJ0RDTsKXxSc9lzzT0C9tMi0jN5xEJ/fVQfl+3G4rOJu+w
	Rn3c9AfYgRqcx5fR58WxIaLdBCc1/mEbJoEbM32X9A8g2pB6uQX4UwoE/6KR6Ncw3QUyZnbTjMy3j
	2IAy+FPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njpdy-003h2e-AR; Wed, 27 Apr 2022 21:56:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njpdu-003h1a-Ai
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 21:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651096575; x=1682632575;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ndxlCJcsWNsxefRwlgceKJ0VvE3NnTsnasUGPtb8I/A=;
 b=EJ4qt9cPTlU/WnZNjoOE77bzKkCZ2N2eTRFTlDn5u3XTl/Pgo+1V0nO6
 IKebUB0DEeXobuFGaSBFL3vLRBG8IBpjGQMTNI0nC3H2L8b2VjhKvSF1i
 vOw19UGyGdmgcmhkiDPDoB0s0dAg0ZFdiTxGYV5Kah4T4QTBjjBfJn+hv
 5bKSIQBgZz2ThINXwwd9+kIisAET2f/sgoslL0tfjB3tEycqd0/SViEV0
 /GY1KgUHXzH3GTiGBPzfvnHZCp9rAl/zwu7CQSkam5z4oiKz8sCuzKlLO
 guMM6kwe2km9Z/jWzV9F8dhivhwmx5v1QIaNeHzS+Q23QYikp5gRzDtqO Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="199888164"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 05:56:12 +0800
IronPort-SDR: gg6Ax4Xa4+BpBOPSPwUYrwxSwS7Dz7/lvJzhxZpl2eZrZNocOz8d17JEVxYVTwK/hQYcH/f/ay
 e6w+GM6RleVeIzvX6LVg7V9UerBiemGan9LSufshan6YZcWuKweGHO+vkwszzgtYU4DT2EbzOB
 8hvwdXG4MzW4hisn8f5p/kvTfXMiJIAqGAJKJnk9+2dAEhgpdoqsRt5FKbBmEh7d1EbFASZ/GH
 r9oc7KVQwR5pZtRmO6hPxtTrYG9M2QQD8g9OQ9i1D3c5gKPZryrUeUAl5c1EENqvRpK0G03Sem
 LdtcYXSgmxaQ5EhBhGyQL4hD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:27:03 -0700
IronPort-SDR: +awf6sEKrr+xN/fjblZOIYWnZ91XkexJizkZulzNNvWVDyavPdWjo/KIoszzhvBbEHwz+7liMM
 DtDLmearvx+W7lzBf6am5Eq4DFjrCW1TSkSi1EyGm+3Kd9X6pBJEU+F9Ed9ups97xqT9kNuMgV
 1lnMdfw1qInoVkH5iZ6DiePdR2lCO27CSKSvcDaaijhTBv5nGF4eBaS2wP4rUxi+n3M0EezxPJ
 9o3UqOhh2RcZ8kgU2R4YZHPupacgqPlQkvEed0UimiVxiRWhzW/NoGnz73QL4/jXk9blSTxSov
 dWQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:56:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXd65nW6z1SVny
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 14:56:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651096569; x=1653688570; bh=ndxlCJcsWNsxefRwlgceKJ0VvE3NnTsnasU
 GPtb8I/A=; b=e3SQWIC7isONhMVABcQXbRoKsYP01AGBbkTTjAVX/tATNA9akqV
 o0SzlNWttcnvWNegaIDqsgtVaRN7EVxQ3KYkcm+l9jYgyZmBuBYBE4JaxLs2gHlp
 W1W8Mvuy7yp4sC9d1mSOqpu2vkVNAa4MzcfMRY1QziIs9+dyJcsECcIpZDlx7FnA
 sLmbmraKN3ndEuoI8banOkqH+BI0AIeOKJ0Jrr31eP4b5BaP469/vPWfa5e+E+C4
 3D/ZgYZzzLxhG1LuI1msi7Jn0cK1sHIIimzpgNd8UB6ilKxM3M2xEHUkmkK7FsyN
 iTtpZ7+j79y0W+8DaWFHsJGQlJCaD693HFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id JuqjWLe4LSr6 for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 14:56:09 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXd44RlGz1Rvlc;
 Wed, 27 Apr 2022 14:56:08 -0700 (PDT)
Message-ID: <3f80a126-e52a-955b-aca4-14218d26faf5@opensource.wdc.com>
Date: Thu, 28 Apr 2022 06:56:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
 <20220427153826.GE9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427153826.GE9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_145614_530435_C433D257 
X-CRM114-Status: GOOD (  20.01  )
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

On 4/28/22 00:38, Nitesh Shetty wrote:
> On Wed, Apr 27, 2022 at 10:46:32AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>>
>>> 2. Block layer
>>> - Block-generic copy (REQ_COPY flag), with interface accommodating
>>>     two block-devs, and multi-source/destination interface
>>> - Emulation, when offload is natively absent
>>> - dm-linear support (for cases not requiring split)
>>>
>>> 3. User-interface
>>> - new ioctl
>>> - copy_file_range for zonefs
>>>
>>> 4. In-kernel user
>>> - dm-kcopyd
>>> - copy_file_range in zonefs
>>>
>>> For zonefs copy_file_range - Seems we cannot levearge fstest here. Li=
mited
>>> testing is done at this point using a custom application for unit tes=
ting.
>>
>> https://protect2.fireeye.com/v1/url?k=3Db14bf8e1-d0361099-b14a73ae-74f=
e485fffb1-9bd9bbb269af18f9&q=3D1&e=3Db9714c29-ea22-4fa5-8a2a-eeb42ca4bdc1=
&u=3Dhttps%3A%2F%2Fgithub.com%2Fwesterndigitalcorporation%2Fzonefs-tools
>>
>> ./configure --with-tests
>> make
>> sudo make install
>>
>> Then run tests/zonefs-tests.sh
>>
>> Adding test case is simple. Just add script files under tests/scripts
>>
>> I just realized that the README file of this project is not documentin=
g
>> this. I will update it.
>>
>=20
> Thank you. We will try to use this.
> Any plans to integrate this testsuite with fstests(xfstest) ?

No. It is not a good fit since zonefs cannot pass most of the generic tes=
t
cases.

>=20
> --
> Nitesh Shetty
>=20
>=20


--=20
Damien Le Moal
Western Digital Research

