Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D444C77B6F
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=VGr1dXcVug5jWFRjhyP5yHrMbpFmYORGRUjHZROX8/s=; b=jMFqrsTOqbzj5RQ1pZtOas5G7R
	CrrAhaDWVLhTdCMeY3wodF4bmBqljwMVpfPZ8ni7lDsCc/PTfnMffSwE8qweOgh/G56OGw2+0jCE8
	Xtm63sXUCQQATYfz2vJC09C2NaYsaHDZUUoeWJ1JMXXBWKudVhnfNW9YXHhjXgkYLo5fZ0gdIoUdi
	637jmbzRVlQ42I2xyw9sn6Gfifilj80KhjXdecLKoATfhHwF6N5cThJolNgfXhNcBD3EfSmu8A/tj
	NYes6/Zs9rP8OqhrtQIK7coSINIsOlCR7Tkepxw96UY9Nd7VZdPHj1NAGXR3Au3mJkaYXCamG2T4l
	H2CBvqpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkR6p-007j6o-2b;
	Thu, 06 Apr 2023 15:01:07 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkA1i-005fs7-2V
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 20:46:49 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230405204637usoutp015ef6b6614e9934f7d73974181ef158ee~TJNhvFsWs1469714697usoutp01c;
	Wed,  5 Apr 2023 20:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230405204637usoutp015ef6b6614e9934f7d73974181ef158ee~TJNhvFsWs1469714697usoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680727597;
	bh=VGr1dXcVug5jWFRjhyP5yHrMbpFmYORGRUjHZROX8/s=;
	h=From:To:CC:Subject:Date:References:From;
	b=O3w88ECkjEe8knXqb2p0YBFjONNZpUs77Lmgux6H6ciyUTidBwFvHzmto6XZl8NHp
	 ipWEkQs9Qzq0mGI0+xRp8rKldzGmfex0gVSLRn45SfkWsVE0Au0KJyoMc8ufClP8MZ
	 9kpJj7n3daIO01iFND5UpS3QIP2ibJXhl8kWWIRU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230405204637uscas1p1706736250917ab88edbe4af6a5b4fe81~TJNhj7HFh1825818258uscas1p1L;
	Wed,  5 Apr 2023 20:46:37 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id EB.42.09634.D2EDD246; Wed, 
	5 Apr 2023 16:46:37 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230405204637uscas1p2fb449663414a31f130fd5b02caac3340~TJNhPr82H1349813498uscas1p2B;
	Wed,  5 Apr 2023 20:46:37 +0000 (GMT)
X-AuditID: cbfec36d-71bff700000025a2-bc-642dde2d8917
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id EA.0B.09541.D2EDD246; Wed, 
	5 Apr 2023 16:46:37 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 5 Apr 2023 13:46:36 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	5 Apr 2023 13:46:36 -0700
From: Nate Thornton <nate.thornton@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: nvme: Incorrect Async Event Trace string
Thread-Topic: nvme: Incorrect Async Event Trace string
Thread-Index: Adln9MG4z0NU2uKCTiKEWprdC5v+bQ==
Date: Wed, 5 Apr 2023 20:46:36 +0000
Message-ID: <6f4a7ffad0c7495391116b8b983882b3@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djX87q693RTDK4/1LSYdOgao8XlXXPY
	LOYve8ruwOyxaVUnm8fmJfUenzfJBTBHcdmkpOZklqUW6dslcGVMObuUpWCfVMWbiwdYGxib
	RboYOTkkBEwkPq5ay9rFyMUhJLCSUWL1lsksEE4rk8S+459ZYaqW3l3ODJFYyyhx5coqqJaP
	jBIPdn2GcpYySnx/sIwJpIVNQF9i7penzCC2iIC2xOsre8DmMgu0MUqcuvQALCEsYChx7VwD
	C0SRmcS5CzugbD2JJT9/s4HYLAIqEh9PTgC7g1fASuJTbz9YnFFATOL7qTVgy5gFxCVuPZnP
	BHGroMSi2XuYIWwxiX+7HrJB2IoS97+/ZIeo15FYsPsTG4StLbFs4WtmiPmCEidnPmGBqJeU
	OLjiBtjREgKNHBLPT9+CSrhIPDu5EmqZtMTV61OZIQbxSfz99Yixi5EDKM4r0dEmBFHiIXHk
	8XmwvUICsRItXR/YJjDKz0Jy9iwkJ81CctIsJCctYGRZxSheWlycm55abJiXWq5XnJhbXJqX
	rpecn7uJEZg0Tv87nLuDccetj3qHGJk4GA8xSnAwK4nwqnZppQjxpiRWVqUW5ccXleakFh9i
	lOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpgmt+x+wdf2a1jPouip/1/2t+dnyk+QU7o
	t+/ZpCMzgm+fq35Q1nf3Vj1/x/dNydXfqh/JfjHdUqwkp3JVQvv09yu+KeFmvM9lvsXX9N5f
	rhMU+bKnXya6ucxkqcYcLcHvdYfncd2ZFP/lt+SdCQUcCV/+vfgQlvft1o+Fha+f8WtG8fVs
	YE/SXBJgMOvd/bzVYumTKwqtRMt/WHSnnr1dZHmMz6vzmeb9nTK9lX6Tp+qGCiQqpIqmO62t
	/rhFTPPgw8VGLA+cHK5+UJBaunqJV+Ef7oAyq6O/nPmmaXdna5bMs/ihLi2sz3FwQg5P3v6Q
	rrg1Sh3Gy1+tzgk+v9EpQkkp5mLtf5YXcy90XD6gxFKckWioxVxUnAgAJsJoiYkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWS2cA0SVf3nm6KwYFHAhaTDl1jtLi8aw6b
	xfxlT9kdmD02repk89i8pN7j8ya5AOYoLpuU1JzMstQifbsErowpZ5eyFOyTqnhz8QBrA2Oz
	SBcjJ4eEgInE0rvLmbsYuTiEBFYzSnw6PZcdJCEk8JFRYupdqMRSRol3Ly4zgSTYBPQl5n55
	ygxiiwhoS7y+socFpIhZoI1R4tSlB2AJYQFDiWvnGlggiswkzl3YAWXrSSz5+ZsNxGYRUJH4
	eHICK4jNK2Al8am3HyzOKCAm8f3UGrBlzALiEreezGeCOFVAYsme88wQtqjEy8f/WCFsRYn7
	31+yQ9TrSCzY/YkNwtaWWLbwNTPEfEGJkzOfsEDUS0ocXHGDZQKj6CwkK2YhaZ+FpH0WkvYF
	jCyrGMVLi4tz0yuKDfNSy/WKE3OLS/PS9ZLzczcxAuPn9L/DkTsYj976qHeIkYmD8RCjBAez
	kgivapdWihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeIdeJ8UIC6YklqdmpqQWpRTBZJg5OqQam
	ytnOOkZMad2Ve65cctjLpFV4z89vt9e28/dN3F/lLuPXV98t2aX5fNXS+4wh0bETbpcUFR9O
	fXqqMoa9V+T7w4XsO6peqfl+s6gTV2yvfLi0PNfv+dVWC4H5eVILbbw+vpe5I38na46ZSUWV
	W7vX78c7zixuuZVjeF1E91ju7brarUuXmgZG5ioWLtzn38bbuOq0aMbuhdE7lef/D5+yt5yh
	sFpfdMktBnfvmpRMscC3b94/e3Gj2/eZwJKJrw0/f72/t3DKUolm89tViq+XqoUq2pdPv7Sg
	waW1wEUl50zhpsfiz9iKzQK/JV3fUpoxJaLqePRHhnv3Jnyzlki4mrN8OUtX3r/cuV8vepYp
	sRRnJBpqMRcVJwIAWlfQAA4DAAA=
X-CMS-MailID: 20230405204637uscas1p2fb449663414a31f130fd5b02caac3340
CMS-TYPE: 301P
X-CMS-RootMailID: 20230405204637uscas1p2fb449663414a31f130fd5b02caac3340
References: <CGME20230405204637uscas1p2fb449663414a31f130fd5b02caac3340@uscas1p2.samsung.com>
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_134643_293362_B2E6EEA3 
X-CRM114-Status: GOOD (  12.38  )
X-Mailman-Approved-At: Thu, 06 Apr 2023 08:01:06 -0700
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

Hi Keith,

With NVMe Asynchronous Event kernel debug tracing, there are duplicate entr=
ies in the symbolic table that cause the decoded event string to be incorre=
ct for certain events. This is easily observed by enabling SMART / Health e=
vents, then lowering the temperature threshold so the drive will generate a=
n event. I observed the issue on the 5.15 kernel and the trace macro remain=
s the same in 6.x

I am using a Samsung PM173X drive in my testing, but any drive that support=
s asynchronous events and temperature readings should suffice.

e.g.
# Enable NVMe Async Event debug tracing
$ echo 1 > /sys/kernel/debug/tracing/events/nvme/nvme_async_event/enable

# Enable Asynchronous Event Notification for SMART / Critical Health Warnin=
gs (bits 0:7)
$ nvme set-feature /dev/nvme0 --feature-id=3D0xB --value=3D0xF
set-feature:0x0b (Async Event Configuration), value:0x0000000f, cdw12:00000=
000, save:0

# Reduce Temperature Threshold to 64 Kelvin, thus triggering an event (unle=
ss it's cold)
$ nvme set-feature /dev/nvme0 --feature-id=3D0x4 --value=3D0x40

# Observe that the Asynchronous Event Notification (AEN) is 0x000001. This =
corresponds to a SMART / Health status
# but is labeled as NVME_AER_NOTICE_FW_ACT_STARTING
$ cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:20
#
#                                _-----=3D> irqs-off
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [017] d.h..   745.082580: nvme_async_event: nvme0:=
 NVME_AEN=3D0x000001 [NVME_AER_NOTICE_FW_ACT_STARTING]



The AER name duplications are in drivers/nvme/host/trace.h where it tries t=
o combine the Asynchronous Event Type, and types specific to the Notice eve=
nt type. In my case, I should be seeing NVME_AER_SMART.
		aer_name(NVME_AER_NOTICE_NS_CHANGED),		// 0
		aer_name(NVME_AER_NOTICE_ANA),			// 3
		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),	// 1
		aer_name(NVME_AER_NOTICE_DISC_CHANGED),		// 0xF0
		aer_name(NVME_AER_ERROR),				// 0
		aer_name(NVME_AER_SMART),				// 1
		aer_name(NVME_AER_CSS),					// 6
		aer_name(NVME_AER_VS))					// 7
=09

Referring to NVM Express Base Specification, Revision 2.0c, 5.2.1 Command C=
ompletion: The Event Type is in the lower bits 0:3 of Dword 0. The Event Ty=
pe then describes specific Event Information in bits 8:15. (Note that two E=
vent Types are missing: NVME_AER_NOTICE (2) and NVME_AER_IMMEDIATE (3). The=
 other values, 4 and 5, are marked as Reserved in the spec. For completenes=
s, we may want to add the missing definitions.)

In nvme_handle_aen_notice it is decoding bits 8:15 and passing that into th=
e trace. That maybe explains why the NVME_AER_NOTICE_* entries were added t=
o the symbolic names. If this is still desired, it may require a second TRA=
CE_EVENT definition specific to notice events.

Although I am new to the kernel, I am happy to help with a patch if you can=
 describe the desired behavior.

Thanks,
Nate



