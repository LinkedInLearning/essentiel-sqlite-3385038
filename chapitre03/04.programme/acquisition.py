# APScheduler
# pip install APScheduler

from apscheduler.schedulers.blocking import BlockingScheduler
import datetime as dt
import velib

sched = BlockingScheduler()

# Avec ce décorateur , on indique que la fonction doit être appelée 
# régulièrement.
@sched.scheduled_job("interval", minutes=1)
def sched_get_stations():
    print("Récupération des stations à %s" % dt.datetime.now().strftime("%H:%M:%S"))
    velib.get_stations()

velib.create_tables()
sched.start()

