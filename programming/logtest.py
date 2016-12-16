#!/usr/bin/env python

import os, sys
import logging
import logging.handlers


if __name__ == '__main__':
    exe = os.path.basename(sys.argv[0]).split('.')[-2]
    level = logging.DEBUG


    formatter = logging.Formatter(
        '%(asctime)-6s: %(name)s - %(levelname)s - %(message)s')

    consoleLogger = logging.StreamHandler()
    consoleLogger.setLevel(level)
    consoleLogger.setFormatter(formatter)
    logging.getLogger().addHandler(consoleLogger)


    # fileLogger = logging.FileHandler(exe + '.log')
    # fileLogger.setLevel(level)
    # fileLogger.setFormatter(formatter)
    # logging.getLogger().addHandler(fileLogger)


    rotateLogger = logging.handlers.TimedRotatingFileHandler(exe+'.log',  'midnight')
    rotateLogger.setLevel(level)
    rotateLogger.setFormatter(formatter)
    logging.getLogger().addHandler(rotateLogger)



    logger = logging.getLogger(exe)
    logger.setLevel(level)
    logger.info('This is a message')
    logger.error('This is an error message')



