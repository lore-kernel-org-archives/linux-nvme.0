Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BDC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5mSLpe3oAPYlZ2NgHjK8XAAHdE2g7SKYc0B5+oBE/E=; b=EsSnoeEj/gfh5tBqzFpK0RABLO
	5JtJu3vOueyUKLcd4E35zyeMglnK2+AAsnubgW9ciB0jsKXSpavUJ2jIl1jNQrxw7MGuoySPqdnlr
	X5rhUJN/3bWj6QVx5axzqoiaCnt0eOjySSVi576gWJmE+NW1EGqB+hg6NUUjKJWXGl8D0V5NVvkAb
	Jh6a8Q3mqlBPOuhANAmLgCxN4QmgxqcTHKLEdazaz3Jbihoxxb3xzNB3/J9jHP8glzzXUF8r9DFuf
	dpY5+Y+wZmvmyGRvMzdyyTBTf9vsJPiO0uxlTTYh8/we2V6G2mWj+ySwAY47Bm//SP5iqVGMkT9FQ
	8emFeZRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0OOn-001unS-2Q;
	Tue, 07 Nov 2023 15:53:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0OOk-001uko-1L
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 15:53:51 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7FqjvZ009867;
	Tue, 7 Nov 2023 15:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=U5mSLpe3oAPYlZ2NgHjK8XAAHdE2g7SKYc0B5+oBE/E=;
 b=TiXWLSOTI6SxG9f9Cs3dioklkWFE3M4aeP8M4gFpkZ8p+WaEnA58nannoQa57zvq/dF9
 Kq8/A4hN8v6/o7kz1SmSD/Poslli10WbiolwXDut/oUDkYBUIm7gbpXI3a7qrzCrHYUG
 60Cf2qoJR/JOl1pstUDW2gAujeFQwJ1NAOOox1wFkDENWpOsVIMQY85ZhdDR95rfwDEe
 5HDxS39uGbyProATxAgY8z2LbjRKkHfljs4uDsC5hExtwy4QEuPfOQnJkoErKNvgqSE/
 YIfIXMdX9nbbO301eMTrmgCsPaWQOSQVsF+5LHIMXzHKhxDfVsCuJlPUKJbhms8URmGR hw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7r5tr5u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 15:53:39 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7E8EYr028276;
	Tue, 7 Nov 2023 15:53:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gk19sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 15:53:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7Frbml15663698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 15:53:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F73B5805B;
	Tue,  7 Nov 2023 15:53:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA6058060;
	Tue,  7 Nov 2023 15:53:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 15:53:36 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 07 Nov 2023 09:53:36 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig
 <hch@infradead.org>, linux-nvme@lists.infradead.org,
        Wenxiong
 <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
In-Reply-To: <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
 <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
 <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
 <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <57b97925c57cef94d60e422f9cbf15c7@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e0GP-gIgDzbdynxzvK4y_-54xDfuCZGW
X-Proofpoint-ORIG-GUID: e0GP-gIgDzbdynxzvK4y_-54xDfuCZGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_07,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0 mlxlogscore=704
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_075350_572479_BFD4F8AF 
X-CRM114-Status: GOOD (  20.58  )
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

On 2023-11-07 09:18, Keith Busch wrote:

Hi Keith,

> "rescanning namespaces" message right after the 'detach-ns' command, 
> and
> before subsequent 'attach-ns' command. It looks here that the rescan
> didn't run until after the 'attach-ns' occured. Instead of tearing down
> the original, the driver just sees the namespace it previously knew
> about has changed unexpectedly; the processing for the namespace 
> removal
> didn't happen prior to the attach-ns command.

Re-did:
# nvme detach-ns /dev/nvme0 --namespace-id=1 --controllers=0x81
detach-ns: Success, nsid:1
# dmesg
[ 4804.431303] nvme nvme0: rescanning namespaces
# nvme delete-ns /dev/nvme0 --namespace-id=1
delete-ns: Success, deleted nsid:1
# dmesg
[ 4804.431303] nvme nvme0: rescanning namespaces.
# nvme create-ns /dev/nvme0 --nsze=562805846 --ncap=562805846 --flbas=0 
-dps=0 -nmic=1
create-ns: Success, created nsid:1
[root@ltcrain119-lp4 ~]# dmesg
[ 4804.431303] nvme nvme0: rescanning namespaces.


> If you drop all open references to /dev/nvme0n1, then the handle should
> get deleted, and a manual rescan after that should get your new
> namespace visible.

# nvme attach-ns /dev/nvme0 -n 1  --controller=0x81
attach-ns: Success, nsid:1
# dmesg
[ 4804.431303] nvme nvme0: rescanning namespaces.
[ 5219.493625] nvme nvme0: rescanning namespaces.
[ 5219.502136] nguid mismatch
[ 5219.502146] nvme nvme0: identifiers changed for nsid 1
[ 5219.506668] block nvme0n1: no usable path - requeuing I/O
[ 5219.662788] block nvme0n1: no available path - failing I/O
[ 5219.662824] block nvme0n1: no available path - failing I/O
[ 5219.662841] Buffer I/O error on dev nvme0n1, logical block 281402912, 
async page read
[ 5219.662859] block nvme0n1: no available path - failing I/O
[ 5219.662875] Buffer I/O error on dev nvme0n1, logical block 281402913, 
async page read
[ 5219.662887] block nvme0n1: no available path - failing I/O
[ 5219.662894] Buffer I/O error on dev nvme0n1, logical block 281402914, 
async page read
[ 5219.662913] block nvme0n1: no available path - failing I/O
[ 5219.662926] Buffer I/O error on dev nvme0n1, logical block 281402915, 
async page read
[ 5219.662956] block nvme0n1: no available path - failing I/O
[ 5219.662970] Buffer I/O error on dev nvme0n1, logical block 281402916, 
async page read
[ 5219.662985] bio_check_eod: 7 callbacks suppressed
[ 5219.662988] systemd-udevd: attempt to access beyond end of device
                nvme0n1: rw=0, sector=4502446672, nr_sectors = 16 limit=0
[ 5219.663022] Buffer I/O error on dev nvme0n1, logical block 281402917, 
async page read
[ 5219.663035] systemd-udevd: attempt to access beyond end of device
                nvme0n1: rw=0, sector=4502446688, nr_sectors = 16 limit=0
[ 5219.663052] Buffer I/O error on dev nvme0n1, logical block 281402918, 
async page read
[ 5219.663065] systemd-udevd: attempt to access beyond end of device
                nvme0n1: rw=0, sector=4502446704, nr_sectors = 16 limit=0
[ 5219.663099] Buffer I/O error on dev nvme0n1, logical block 281402919, 
async page read
# nvme ns-rescan /dev/nvme0n1
/dev/nvme0n1: No such file or directory
Usage: nvme ns-rescan <device> [OPTIONS]

Rescans the NVMe namespaces

# nvme ns-rescan /dev/nvme0n1
/dev/nvme0n1: No such file or directory
Usage: nvme ns-rescan <device> [OPTIONS]

Rescans the NVMe namespaces

# ls -l /dev/nvme*
crw-------. 1 root root 240, 0 Nov  7 08:26 /dev/nvme0
crw-------. 1 root root 240, 1 Nov  7 08:13 /dev/nvme1
brw-rw----. 1 root disk 259, 1 Nov  7 08:13 /dev/nvme1n1

[root@ltcrain119-lp4 ~]# nvme attach-ns /dev/nvme0 -n 1  
--controller=0x81
NVMe status: Namespace Already Attached: The controller is already 
attached to the namespace specified(0x2118)

[root@ltcrain119-lp4 ~]# ls -l /dev/nvme*
crw-------. 1 root root 240, 0 Nov  7 08:26 /dev/nvme0
brw-rw----. 1 root disk 259, 3 Nov  7 09:48 /dev/nvme0n1
crw-------. 1 root root 240, 1 Nov  7 08:13 /dev/nvme1
brw-rw----. 1 root disk 259, 1 Nov  7 08:13 /dev/nvme1n1

After attach-ns command, /dev/nvme0n1 is not showed up in /dev/*, 
somehow I have to do the 2nd attach-ns command, nvme ns-rescan works 
after the 2nd attach-ns.

Is a firmware issue on nvme device?

Thanks,
Wendy


