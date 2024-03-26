Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF7C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSDRRZfw0dn+QI+sEEl8KYY1A8VbVM5EU/tJDuS5wEI=; b=T4Ft/A8WaZ4GvNvmIb+Aet6fwR
	MyqmWRDd1FVsyYIxYMH+t5hk0SzbHqt8o4mrh78URoGtSZfKhZFGsNFUbqPiOaUXwnlg0BcHXYD+B
	Sh1DE623/aWwiHeDWBYF1go/Z1YXRRSSB6e9d9uoWP8eT7jp5ZQukFnWEQqR95iq+AiMdzt9RTTbL
	Fru7XarKp3sjOLozzm39u9j6infBSZQ55E8BPHOXO89Y2JAFBtJb/t0/xxe3b7ckrooLrAsFMTslR
	DaB53IBo7pmx0u2AjWsq3yYjpHtCN8Y/nqveJMKojqxJEnrsW2Z5e/KFOnOXRuii+72MMV6JFB+sz
	8MWSj1Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2Vn-00000003fc1-1zjt;
	Tue, 26 Mar 2024 08:50:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2Vk-00000003fb5-2agS
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 08:50:26 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q86MDp009379;
	Tue, 26 Mar 2024 08:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YSDRRZfw0dn+QI+sEEl8KYY1A8VbVM5EU/tJDuS5wEI=;
 b=kRS+yE7zp17IN+s/XiPvE2Kvoj4Rw+owZuufRJ9j5PkUR+euCkdSjjOl+yZdYLyI4UWQ
 D6y/j12LwYasMhph9bG4Cy8c6sZ1EPz84C6+7E/SUtXELmnZA/t9BYJPa1IX1yjpOJGW
 qRT+39+IbiR4FRk3mdj0OC84Gy6IFoGM2uoXtZONvXWp1N/KjpQlHnMER/Allwhcboy/
 hHI7MKMb2fkd8BA7NyFt/GlYMCbAp9OvBm9sPGLjtbin3pa3Vg4/hZKlE6rzUcczlj93
 mZpPgs1A6cSu8bKtFesadMXLcl0jUADQNnEK/vm6Ix0nfzpfA98AjIqbZgIxXnuUQQuc 3g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3krygyt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:50:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6GhFd028675;
	Tue, 26 Mar 2024 08:50:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp6nc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:50:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q8oFUH48038234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 08:50:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F2A5806F;
	Tue, 26 Mar 2024 08:50:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0695806B;
	Tue, 26 Mar 2024 08:50:13 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 08:50:13 +0000 (GMT)
Message-ID: <5c54f9eb-6a86-4240-bba8-eee8b72469c2@linux.ibm.com>
Date: Tue, 26 Mar 2024 14:20:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree: Add NVM subsystem controller identifier
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com
References: <20240326065752.164286-1-nilay@linux.ibm.com>
 <7bfe1296-3bd6-4c5e-a1a7-5fdb5c346404@suse.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7bfe1296-3bd6-4c5e-a1a7-5fdb5c346404@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _6Yf0fur-sE6LM-53XFTqPDdlbZdTAky
X-Proofpoint-GUID: _6Yf0fur-sE6LM-53XFTqPDdlbZdTAky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_015024_833911_B16CBE3F 
X-CRM114-Status: GOOD (  27.08  )
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



On 3/26/24 12:40, Hannes Reinecke wrote:
> On 3/26/24 07:57, Nilay Shroff wrote:
>> This commit introduces a field "cntlid" for controller,
>> that contains the NVM subsystem unique identifier assigned
>> to each controller device in an NVM subsystem.
>>
>> While attaching a namespace, typically user needs to specify the
>> controller identifier (cntlid). The cntlid could be referenced from
>> sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
>> a direct option.
>>  > Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> Hi all,
>>
>> While attaching an NVMe namespace using nvme-cli command
>> "nvme attach-ns", we need to specifiy controller identifier
>> (cntlid) against which the namespace is being attached.
>>
>> Not specifying cntlid while attaching namespace would result in
>> no actual change in namespace attachment. For instance,
>>
>> # nvme create-ns /dev/nvme0 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096
>> create-ns: Success, created nsid:1
>>
>> # nvme attach-ns /dev/nvme0 -n 1
>> warning: empty controller-id list will result in no actual change in namespace attachment
>> attach-ns: Success, nsid:1
>>
> 
> Errm. How would that work? /dev/nvme0 _is_ a controller, and as such will have an assigned cntlid. And if one would issue an 'attach-ns'
> command the only controller which it could address is that controller
> to which the command is issued.
> I'd be _very_ surprised if you could issue 'attach-ns' against _another_
> controller. So why do we need this option?
> Shouldn't we rather infer the cntlid from the existing controller?
> 
Yes it's possible to attach a namespace against the cntlid which could be different from 
the nvmeX device we use while attaching the namespace. Moreover, if we want to create a shared 
namespace then we need to specify all controller identifiers which would share that namespace.

For reference, I would show the example output below:

Example 1: Create a shared namespace and attach to multiple controllers:
------------------------------------------------------------------------

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys1     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3
[...]

As we could see above I have two controllers (nvme1 and nvme3) under NVM subsys1. 
Lets find cntlid of each controller.

# cat /sys/class/nvme/nvme1/cntlid 
66 
# cat /sys/class/nvme/nvme3/cntlid 
65

Now create a shared namespace and attach it against the above controllers:

# nvme create-ns /dev/nvme1 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096 -m 1 
create-ns: Success, created nsid:1

# nvme attach-ns /dev/nvme1 -n 0x1 -c 65,66 
attach-ns: Success, nsid:1

# nvme list -v
[...]

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3


As we could see above for creating shared namespace we need to know the cntlid of both 
nvme1 and nvme3 controllers.

Example 2: Create a private namespace and attach to a controller other than the one specified in nvmeX
------------------------------------------------------------------------------------------------------

# nvme create-ns /dev/nvme1 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096
create-ns: Success, created nsid:2

# nvme attach-ns /dev/nvme1 -n 2 -c 65
attach-ns: Success, nsid:2

Please note above that I attached the namespace against controller nvme3 (the cntlid 65 is assigned to nvme3)

# nvme list -v
[...]

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
/dev/nvme1n2 /dev/ng1n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3

Thanks,
--Nilay

