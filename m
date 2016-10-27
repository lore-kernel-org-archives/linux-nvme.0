From: qiuxin@huawei.com (Qiuxin (robert))
Date: Thu, 27 Oct 2016 06:57:56 +0000
Subject: A question regarding "multiple SGL"
In-Reply-To: <20161027064115.GA5864@lst.de>
References: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
 <20161027064115.GA5864@lst.de>
Message-ID: <B78D1A958924E54594997EFF975251625BD49445@szxeml592-mbx.china.huawei.com>

Hi Christoph,

Thanks , got it.

Could you please do me favor to let me know the background why we ONLY support " MSDBD ==1"?   I am NOT trying to resist or oppose anything , I just want to know the reason.  You know,  it is a little wired for me, as  "MSDBD ==1" does not fulfill all the use cases which is depicted in the spec.

Best,
Robert Qiuxin
________________________________________
Robert Qiuxin
???????? Huawei Technologies Co., Ltd.
Phone: +86-755-28420357
Fax: 
Mobile: +86 15986638429
Email: qiuxin at huawei.com
??????????????? ???518129
Huawei Technologies Co., Ltd.
Bantian, Longgang District,Shenzhen 518129, P.R.China
http://www.huawei.com 
________________________________________
????????????????????????????????????????
????????????????????????????????????????
???????????????????????????????????
This e-mail and its attachments contain confidential information from HUAWEI, which 
is intended only for the person or entity whose address is listed above. Any use of the 
information contained herein in any way (including, but not limited to, total or partial 
disclosure, reproduction, or dissemination) by persons other than the intended 
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by 
phone or email immediately and delete it!
-----????-----
???: Christoph Hellwig [mailto:hch at lst.de] 
????: 2016?10?27? 14:41
???: ??
??: Bart Van Assche; Jens Axboe; linux-block at vger.kernel.org; James Bottomley; Martin K. Petersen; Mike Snitzer; linux-rdma at vger.kernel.org; Ming Lei; linux-nvme at lists.infradead.org; Keith Busch; Doug Ledford; linux-scsi at vger.kernel.org; Laurence Oberman; Christoph Hellwig; Tiger zhao; Qiuxin (robert)
??: Re: A question regarding "multiple SGL"

Hi Robert,

There is no feature called "Multiple SGL in one NVMe capsule".  The NVMe over Fabrics specification allows a controller to advertise how many SGL descriptors it supports using the MSDBD Identify field:

"Maximum SGL Data Block Descriptors (MSDBD): This field indicates the maximum number of (Keyed) SGL Data Block descriptors that a host is allowed to place in a capsule. A value of 0h indicates no limit."

Setting this value to 1 is perfectly valid.  Similarly a host is free to chose any number of SGL descriptors between 0 (only for command that don't transfer data) to the limit imposed by the controller using the MSDBD field.

There are no plans to support a MSDBD value larger than 1 in the Linux NVMe target, and there are no plans to ever submit commands with multiple SGLs from the host driver either.

Cheers,
	Christoph
