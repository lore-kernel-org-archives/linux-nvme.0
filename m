From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 11 Oct 2017 17:35:22 +0300
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <2b6780b5-29f6-72f3-5d40-9737710b94d9@grimberg.me>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-5-git-send-email-israelr@mellanox.com>
 <2b6780b5-29f6-72f3-5d40-9737710b94d9@grimberg.me>
Message-ID: <7b7c1c96-dee7-d5ee-6ffe-10cb125dc1f2@mellanox.com>



On 10/11/2017 2:20 PM, Sagi Grimberg wrote:
> 
>> This allows the user to close any connection from target side
>> by writing to the file "force_close" at the controller folder.
>> Full path:
>> /config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/force_close 
>>
> 
> Why not rmdir?

Theese dirs weren't created by mkdir..
