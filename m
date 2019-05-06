From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 01:38:22 +0900
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>

On 5/7/19 1:25 AM, Chaitanya Kulkarni wrote:
> We need to get rid of the string comparison here.
Chaitanya,

Do you mean that test case bash script should check the result of output 
and return some error value instead of zero instead of *.out comparison ?

Thanks,
