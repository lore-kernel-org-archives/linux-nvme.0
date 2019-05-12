From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 15:23:20 +0000
Subject: [PATCH 2/2] nvme-fabrics: Remove unused argument
References: <20190511134255.6790-1-minwoo.im.dev@gmail.com>
 <20190511134255.6790-3-minwoo.im.dev@gmail.com>
 <SN6PR04MB4527A361940ECE60AFE846E5860D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <35242331-5597-0cb5-e72b-4ceedca71f4c@gmail.com>
Message-ID: <SN6PR04MB4527A2971F94EA912B5214A6860E0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


On 5/11/19 3:05 PM, Minwoo Im wrote:
>> Variable "count" use removed by  any commit ?
>>
>> Or it is been like that since the introduction of this function ?
> If you do "blame" with the first line of this function, you can see the 
> count has been introduced without being used at all.
>
> Commit 07bfcd09a ("nvme-fabrics: add a generic NVMe over Fabrics library")
>
