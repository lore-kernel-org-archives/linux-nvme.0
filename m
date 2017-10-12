From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 12 Oct 2017 18:58:46 +0300
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <d06594ae-225e-8065-bead-019c99f309ad@gmail.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-4-git-send-email-israelr@mellanox.com>
 <d06594ae-225e-8065-bead-019c99f309ad@gmail.com>
Message-ID: <f8a2c50d-2f4e-588a-e39d-3c4692037bb5@mellanox.com>



On 10/12/2017 3:16 PM, roy wrote:
> hi,
> 
> Consider exposing all the info about the port (trtype, adrfam, etc') 
> maybe by symlink the controller to to port config_item.

We tought about it, but since we create the dirs dynamically (and not by 
the user performing mkdir), we prefered not to hack this symlink at 
first stage.
