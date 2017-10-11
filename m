From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:20:25 +0300
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <1507635633-16665-5-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-5-git-send-email-israelr@mellanox.com>
Message-ID: <2b6780b5-29f6-72f3-5d40-9737710b94d9@grimberg.me>


> This allows the user to close any connection from target side
> by writing to the file "force_close" at the controller folder.
> Full path:
> /config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/force_close

Why not rmdir?
