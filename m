Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DFEC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED5A610FA
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3ED5A610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:From:
	Subject:To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hQqH8qox4Sk8hj9u7Lz+KiuMXshsLPnryB8BZjvpPtc=; b=14v/rxi1aPixfm
	iOOea3yTDSGQdFklIaq+RRdy5BSJ/ml5NW553jfFxO77Dk3N3zofLFGrSBbkIDspi/hMumNe/bwVO
	yQAG7151c5tr1HadircbsCNYK9gj9Ew2re5O5NR33GPab95yo7QhKID6uQd++sac5iREh8NYuD8Tu
	GJTOtBhSmgLLlOneQ2+oTFBLCEih5GWTdYs1hdMuu9ImtN3SjWaU22BXDGPfVNrMrFYf3ZIU3AwAX
	kpIJ8sUKTUfakwhbDOht6EBt5S/bP/dauWcTcEv4szIR6mjEH3XMFng3RH8G1TvXvqzcgGRr9wcgD
	LgUB9Dnq+gCZQ6s4BGmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGj1G-008ekN-Fr; Thu, 19 Aug 2021 14:27:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGj1B-008ejo-6h
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 14:27:45 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17JE30Qx063485
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=to : subject : from :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=vWRtwIGVTscf3XayG8KeKVy/AaHK0tdZHYdpQAF/DLU=;
 b=CsmjFuXhjFV8oWMwqWPp8wuVtFL4ys8j6i7beGpQLAyYZprJCExC5jgUr17bixcDsXqI
 wFaycJxY0d2KL5KENqSmEki8BKSh1Lu2mdk/j7EpqJoJhPljSuRevrIEeBwWVQMBUVCW
 e4GBAT4JPSp7JpilJgDSFOUbEh40AumJrV+z6PiNpIEI43XPCXkldDYkVHIVjDmw/MrD
 7g2g68ppe13+QWB+QyEA8Fyg/Xodchgcd1NVfc2O8V7WQVk9Lsu7Bx40gFjHIykaPqnA
 Pcwzk1rVU+ihWO4pzdVf4DxayY6exA+c6j5Ir2OGE8A6Au/WCSNzobawzpQ4utUZjDC3 qA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ahp9x5kgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 10:27:40 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JEDJ6W011147
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:39 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 3ae5fg2ra4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:39 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 17JERbcU40894732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:37 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C45BE053
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:37 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B59BBE059
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:37 +0000 (GMT)
Received: from mww0322.dal12m.mail.ibm.com (unknown [9.208.69.18])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:27:37 +0000 (GMT)
To: linux-nvme@lists.infradead.org
Subject: hostname cannot be used for traddr?
From: "Andreas Luengen" <LUENGEN@de.ibm.com>
Message-ID: <OF6B2D5E85.F00AD733-ONC1258736.004F4A7C-C1258736.004F6E51@ibm.com>
Date: Thu, 19 Aug 2021 16:27:35 +0200
MIME-Version: 1.0
X-KeepSent: 6B2D5E85:F00AD733-C1258736:004F4A7C; name=$KeepSent; type=4
X-Mailer: HCL Notes Release 11.0.1 March 21, 2020
X-Disclaimed: 18283
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3xZ3DeSdySCU4PGE88n8n0CO0yr9VCGD
X-Proofpoint-GUID: 3xZ3DeSdySCU4PGE88n8n0CO0yr9VCGD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-19_04:2021-08-17,
 2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=623
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_072741_305611_82C1B9F6 
X-CRM114-Status: GOOD (  16.83  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi nvmetcli developers.

Following the NVMe specs I understand that it should be possible to use =

host name or fully qualified domain name instead of an IP address in the =

traddr field.
Setting the host name works, but when I try to attach a device this fails. =

Just changing the host name to a valid IP address and then attaching a =

device works (see below).

May I  miss something or is this a bug?


/ports/3/subsystems> cd ..
/ports/3> ls
o- 3 =

...........................................................................=
... =

[trtype=3Drdma, traddr=3D172.16.80.97, trsvcid=3D4420]
  o- referrals =

...........................................................................=
.................................... =

[...]
  o- subsystems =

...........................................................................=
................................... =

[...]
/ports/3> set addr traddr=3Dcesip1
Parameter traddr is now 'cesip1'.
/ports/3> ls
o- 3 =

...........................................................................=
......... =

[trtype=3Drdma, traddr=3Dcesip1, trsvcid=3D4420]
  o- referrals =

...........................................................................=
.................................... =

[...]
  o- subsystems =

...........................................................................=
................................... =

[...]
/ports/3> cd subsystems
/ports/3/subsystems> ls
o- subsystems =

...........................................................................=
..................................... =

[...]
/ports/3/subsystems> create cesnode1-0005
Could not symlink cesnode1-0005 in configFS: [Errno 22] Invalid argument: =

'/sys/kernel/config/nvmet/subsystems/cesnode1-0005' -> =

'/sys/kernel/config/nvmet/ports/3/subsystems/cesnode1-0005'
/ports/3/subsystems> cd ..
/ports/3> set addr traddr=3D172.16.80.97
Parameter traddr is now '172.16.80.97'.
/ports/3> cd subsystems
/ports/3/subsystems> create cesnode1-0005
/ports/3/subsystems> ls
o- subsystems =

...........................................................................=
..................................... =

[...]
  o- cesnode1-0005 =

...........................................................................=
................................ =

[...]
/ports/3/subsystems> cd /ports
/ports> ls
o- ports =

...........................................................................=
.......................................... =

[...]
  o- 1 =

...........................................................................=
. =

[trtype=3Drdma, traddr=3D172.16.80.98, trsvcid=3D4420]
  | o- referrals =

...........................................................................=
.................................. =

[...]
  | o- subsystems =

...........................................................................=
................................. =

[...]
  |   o- dvtc3a-0005 =

...........................................................................=
.............................. =

[...]
  o- 3 =

...........................................................................=
. =

[trtype=3Drdma, traddr=3D172.16.80.97, trsvcid=3D4420]
    o- referrals =

...........................................................................=
.................................. =

[...]
    o- subsystems =

...........................................................................=
................................. =

[...]
      o- cesnode1-0005 =

...........................................................................=
............................ =

[...]
/ports>
/ports/3> cd subsystems
/ports/3/subsystems> delete cesnode1-0005
/ports/3/subsystems> cd ..
/ports/3> set addr traddr=3Dcesip1.a.b.c.ibm.com
Parameter traddr is now 'cesip1.a.b.c.ibm.com'.
/ports/3> cd subsystems
/ports/3/subsystems> create cesnode1-0005
Could not symlink cesnode1-0005 in configFS: [Errno 22] Invalid argument: =

'/sys/kernel/config/nvmet/subsystems/cesnode1-0005' -> =

'/sys/kernel/config/nvmet/ports/3/subsystems/cesnode1-0005'


Here when I trying to restore a preconfigured config file:

[8.3 root@dvtc3a:/tmp 07:45:18 994]# nvmetcli clear; nvmetcli restore =

/tmp/nvmet.dvtc3a.rdma.nameonly; nvmetcli ls
Traceback (most recent call last):
  File "/usr/lib/python3.6/site-packages/nvmet/nvme.py", line 635, in =

add_subsystem
    "%s/subsystems/%s" % (self._path, nqn))
OSError: [Errno 22] Invalid argument: =

'/sys/kernel/config/nvmet/subsystems/cesnode1-0005' -> =

'/sys/kernel/config/nvmet/ports/3/subsystems/cesnode1-0005'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/sbin/nvmetcli", line 656, in <module>
    main()
  File "/usr/sbin/nvmetcli", line 639, in main
    funcs[sys.argv[1]](savefile)
  File "/usr/sbin/nvmetcli", line 595, in restore
    errors =3D nvme.Root().restore_from_file(from_file)
  File "/usr/lib/python3.6/site-packages/nvmet/nvme.py", line 382, in =

restore_from_file
    abort_on_error=3Dabort_on_error)
  File "/usr/lib/python3.6/site-packages/nvmet/nvme.py", line 363, in =

restore
    Port.setup(self, t, err_func)
  File "/usr/lib/python3.6/site-packages/nvmet/nvme.py", line 687, in =

setup
    port.add_subsystem(s)
  File "/usr/lib/python3.6/site-packages/nvmet/nvme.py", line 637, in =

add_subsystem
    raise CFSError("Could not symlink %s in configFS: %s" % (nqn, e))
nvmet.nvme.CFSError: Could not symlink cesnode1-0005 in configFS: [Errno =

22] Invalid argument: '/sys/kernel/config/nvmet/subsystems/cesnode1-0005' =

-> '/sys/kernel/config/nvmet/ports/3/subsystems/cesnode1-0005'
o- / =

...........................................................................=
.............................................. =

[...]
  o- hosts =

...........................................................................=
........................................ =

[...]
  | o- hostnqn-cesnode1ip1 =

...........................................................................=
........................ =

[...]
  o- ports =

...........................................................................=
........................................ =

[...]
  | o- 3 =

...........................................................................=
..... =

[trtype=3Drdma, traddr=3Dcesip1, trsvcid=3D4420]
  |   o- referrals =

...........................................................................=
................................ =

[...]
  |   o- subsystems =

...........................................................................=
............................... =

[...]
  o- subsystems =

...........................................................................=
................................... =

[...]
    o- cesnode1-0005 =

........................................................... [version=3D1.3, =

allow_any=3D1, serial=3D657df07bdfbd0a8c]
      o- allowed_hosts =

...........................................................................=
............................ =

[...]
      o- namespaces =

...........................................................................=
............................... =

[...]
        o- 1 ................................ =

[path=3D/ibm/scale01/nvme/disk5.img, =

uuid=3D0fa67003-22db-4948-967d-31d30babd814, enabled]
[8.3 root@dvtc3a:/tmp 07:45:38 995]#

[8.3 root@dvtc3a:/tmp 07:45:38 995]# cat /tmp/nvmet.dvtc3a.rdma.nameonly
{
  "hosts": [
    {
      "nqn": "hostnqn-cesnode1ip1"
    }
  ],
  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "cesip1",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "rdma"
      },
      "portid": 3,
      "referrals": [],
      "subsystems": [
        "cesnode1-0005"
      ]
    }
  ],
  "subsystems": [
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1",
        "serial": "657df07bdfbd0a8c",
        "version": "1.3"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/ibm/scale01/nvme/disk5.img",
            "uuid": "0fa67003-22db-4948-967d-31d30babd814"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "cesnode1-0005"
    }
  ]
}

/etc/hosts contains a mapping for this name (a,b,c are substitutes for the =

real entries):
172.16.80.97  cesip1  cesip1.a.b.c.ibm.com

Mit freundlichen Gr=FC=DFen / Kind regards

Andreas Luengen




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
