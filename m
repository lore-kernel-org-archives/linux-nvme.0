From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 17 Jan 2017 10:27:45 +0200
Subject: Monitoring NVMe M.2 temperature
In-Reply-To: <a6d82f2f-9b2f-7309-31fa-30a85c03f01b@hep.caltech.edu>
References: <a6d82f2f-9b2f-7309-31fa-30a85c03f01b@hep.caltech.edu>
Message-ID: <5d4f81ef-16a6-d417-e66c-13e39e0a73e4@grimberg.me>


> Hi All,
>
> I am testing Samsung M.2 drives (SM 961 and 950 PRO) in a Dell quad M.2
> enclosure. Is there a way to monitor the temperature for an individual
> drive ?

nvme smart-log /dev/$nvme_ctrl
